#!/usr/bin/env bash
# Skill Usage Tracker - PreToolUse hook
# Logs skill invocations to a JSONL file for quantitative measurement.
# Logs skill invocations to measure which skills are actually used.
#
# Add to settings.json PreToolUse hooks to activate.
# Must be fast: simple pattern matching, no heavy JSON parsing.

set -euo pipefail

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
LOG_FILE="${PROJECT_ROOT}/.claude/skill-usage-log.jsonl"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
SESSION_ID="${CLAUDE_SESSION_ID:-unknown}"

# Read stdin (tool call JSON) without blocking
INPUT=$(cat)

# Pass through unchanged (hook must not modify the tool call)
echo "$INPUT"

# Extract tool name from the input (best-effort, fast)
TOOL_NAME=$(echo "$INPUT" | grep -o '"tool_name"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"tool_name"[[:space:]]*:[[:space:]]*"//;s/"//' 2>/dev/null || echo "")

# Detect skill invocations by checking for Skill tool or skill-related patterns
IS_SKILL="false"
SKILL_NAME=""

if [ "$TOOL_NAME" = "Skill" ]; then
  IS_SKILL="true"
  SKILL_NAME=$(echo "$INPUT" | grep -o '"skill"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"skill"[[:space:]]*:[[:space:]]*"//;s/"//' 2>/dev/null || echo "unknown")
fi

# Only log skill invocations (keep the log focused)
if [ "$IS_SKILL" = "true" ] && [ -n "$SKILL_NAME" ]; then
  # Append to JSONL (atomic write via temp file)
  echo "{\"ts\":\"${TIMESTAMP}\",\"skill\":\"${SKILL_NAME}\",\"session\":\"${SESSION_ID}\"}" >> "$LOG_FILE"
fi
