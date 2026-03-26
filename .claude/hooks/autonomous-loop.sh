#!/usr/bin/env bash
# autonomous-loop.sh — Ralph Wiggum Stop hook for Claude Code
# When a task file exists at ~/.claude/autonomous/current-task.md,
# blocks exit and re-feeds the task prompt. Otherwise, runs cleanup.
#
# Based on Karpathy's AutoResearch pattern: define metric, loop, measure, keep/discard.
# Safety: max_iterations cap, STOP kill file, iteration logging.

set -euo pipefail

AUTONOMOUS_DIR="$HOME/.claude/autonomous"
TASK_FILE="$AUTONOMOUS_DIR/current-task.md"
STOP_FILE="$AUTONOMOUS_DIR/STOP"
LOG_FILE="$AUTONOMOUS_DIR/log.jsonl"
PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
CLEANUP_HOOK="$PROJECT_ROOT/.claude/hooks/session-cleanup.sh"
HANDOFFS_DIR="$PROJECT_ROOT/_context/handoffs"

# --- Auto-handoff: capture session footprint on every exit ---
# This runs for ALL sessions (autonomous or interactive) as a safety net.
# Always writes an entry so no session is invisible.
auto_handoff() {
  local TODAY=$(date +%Y-%m-%d)
  local TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  local HANDOFF_FILE="$HANDOFFS_DIR/${TODAY}-auto-session-log.md"

  mkdir -p "$HANDOFFS_DIR"

  # Get git changes (staged + unstaged + untracked summary)
  local GIT_DIFF=""
  local GIT_UNTRACKED=""
  if [ -d "$PROJECT_ROOT/.git" ]; then
    GIT_DIFF=$(cd "$PROJECT_ROOT" && git diff --stat HEAD 2>/dev/null | tail -10) || true
    GIT_UNTRACKED=$(cd "$PROJECT_ROOT" && git status --short 2>/dev/null | grep '^?' | head -10 | awk '{print $2}') || true
  fi

  # Get any dmux outputs produced recently (last 2 hours, avoids stale LOG_FILE issue)
  local DMUX_FILES=""
  DMUX_FILES=$(find "$PROJECT_ROOT/.claude/dmux/" -name "*.md" -mmin -120 2>/dev/null | head -10) || true

  # Get recently modified files in key directories (catches research/planning sessions)
  local RECENT_FILES=""
  RECENT_FILES=$(find "$PROJECT_ROOT/_product-brain/" "$PROJECT_ROOT/_context/" "$PROJECT_ROOT/.claude/handoffs/" -name "*.md" -mmin -60 2>/dev/null | head -10) || true

  # Get recent memory file changes
  local MEMORY_CHANGES=""
  local MEMDIR="$HOME/.claude/projects/-Users-$USER-Documents-$(basename "$(pwd)")/memory"
  if [ -d "$MEMDIR" ]; then
    MEMORY_CHANGES=$(find "$MEMDIR" -name "*.md" -mmin -60 2>/dev/null | head -5) || true
  fi

  # Always write an entry (the old condition skipped research-only sessions)
  cat >> "$HANDOFF_FILE" << HANDOFF_EOF

---
## Session ended: $TIMESTAMP

### Code changes
\`\`\`
${GIT_DIFF:-"No code changes"}
\`\`\`

### New untracked files
${GIT_UNTRACKED:-"None"}

### Knowledge artifacts touched (last hour)
${RECENT_FILES:-"None"}

### Memory updates
${MEMORY_CHANGES:-"None"}

### DMUX outputs
${DMUX_FILES:-"None"}

HANDOFF_EOF
}

# Always run auto-handoff, regardless of autonomous mode
auto_handoff 2>/dev/null || true

# --- Safety: Check for kill file ---
if [ -f "$STOP_FILE" ]; then
  rm -f "$STOP_FILE"
  # Rename task to completed if it exists
  if [ -f "$TASK_FILE" ]; then
    mv "$TASK_FILE" "$TASK_FILE.stopped-$(date +%Y%m%d-%H%M%S)"
  fi
  # Run cleanup and allow exit
  [ -x "$CLEANUP_HOOK" ] && bash "$CLEANUP_HOOK" 2>/dev/null || true
  exit 0
fi

# --- No task file: normal cleanup + exit ---
if [ ! -f "$TASK_FILE" ]; then
  [ -x "$CLEANUP_HOOK" ] && bash "$CLEANUP_HOOK" 2>/dev/null || true
  exit 0
fi

# --- Task file exists: parse frontmatter and manage iteration ---

# Parse YAML frontmatter (simple grep-based, no yq dependency)
get_frontmatter() {
  local key="$1"
  sed -n '/^---$/,/^---$/p' "$TASK_FILE" | grep "^${key}:" | head -1 | sed "s/^${key}:[[:space:]]*//" | tr -d '"'
}

TASK_NAME=$(get_frontmatter "task")
MAX_ITERATIONS=$(get_frontmatter "max_iterations")
CURRENT_ITERATION=$(get_frontmatter "current_iteration")
METRIC_NAME=$(get_frontmatter "metric")
EVAL_COMMAND=$(get_frontmatter "eval_command")

# Defaults
MAX_ITERATIONS=${MAX_ITERATIONS:-50}
CURRENT_ITERATION=${CURRENT_ITERATION:-0}
TASK_NAME=${TASK_NAME:-"unnamed"}

# Check if we've hit max iterations
if [ "$CURRENT_ITERATION" -ge "$MAX_ITERATIONS" ]; then
  COMPLETED_NAME="$TASK_FILE.completed-$(date +%Y%m%d-%H%M%S)"
  mv "$TASK_FILE" "$COMPLETED_NAME"

  # Log completion
  echo "{\"event\":\"completed\",\"task\":\"$TASK_NAME\",\"iterations\":$CURRENT_ITERATION,\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" >> "$LOG_FILE"

  # Run cleanup and allow exit
  [ -x "$CLEANUP_HOOK" ] && bash "$CLEANUP_HOOK" 2>/dev/null || true
  exit 0
fi

# --- Increment iteration counter in task file ---
NEXT_ITERATION=$((CURRENT_ITERATION + 1))
if [ "$(uname)" = "Darwin" ]; then
  sed -i '' "s/^current_iteration:.*/current_iteration: $NEXT_ITERATION/" "$TASK_FILE"
else
  sed -i "s/^current_iteration:.*/current_iteration: $NEXT_ITERATION/" "$TASK_FILE"
fi

# --- Run eval command if present ---
METRIC_VALUE=""
if [ -n "$EVAL_COMMAND" ]; then
  METRIC_VALUE=$(eval "$EVAL_COMMAND" 2>/dev/null | tr -d '[:space:]') || METRIC_VALUE="error"
fi

# --- Log iteration ---
echo "{\"event\":\"iteration\",\"task\":\"$TASK_NAME\",\"iteration\":$NEXT_ITERATION,\"max\":$MAX_ITERATIONS,\"metric\":\"$METRIC_VALUE\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" >> "$LOG_FILE"

# --- Log to results TSV ---
RESULTS_FILE="$AUTONOMOUS_DIR/results/${TASK_NAME}-results.tsv"
if [ ! -f "$RESULTS_FILE" ]; then
  echo -e "iteration\tmetric_value\tstatus\tdescription\ttimestamp" > "$RESULTS_FILE"
fi
echo -e "$NEXT_ITERATION\t$METRIC_VALUE\tpending\titeration $NEXT_ITERATION\t$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$RESULTS_FILE"

# --- Extract task instructions (everything after second ---) ---
TASK_BODY=$(sed '1,/^---$/d' "$TASK_FILE" | sed '1,/^---$/d')

# --- Block exit and re-feed prompt ---
# The reason field becomes the prompt Claude sees when it tries to stop
CONTINUE_PROMPT="AUTONOMOUS LOOP: Iteration $NEXT_ITERATION/$MAX_ITERATIONS for task '$TASK_NAME'.

Current metric ($METRIC_NAME): $METRIC_VALUE

$TASK_BODY

IMPORTANT: You are in autonomous mode. Do NOT ask the user if you should continue. Do NOT pause for confirmation. Execute one unit of work, then let the session end naturally (the hook will restart you). If you run out of ideas, think harder. The loop runs until max iterations or the user creates ~/.claude/autonomous/STOP."

jq -n \
  --arg reason "$CONTINUE_PROMPT" \
  '{
    "decision": "block",
    "reason": $reason
  }'
