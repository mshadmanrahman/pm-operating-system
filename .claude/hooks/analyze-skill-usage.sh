#!/usr/bin/env bash
# Skill Usage Analyzer
# Run manually: bash .claude/hooks/analyze-skill-usage.sh
# Produces a report of skill usage from the JSONL log.

set -euo pipefail

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
LOG_FILE="${PROJECT_ROOT}/.claude/skill-usage-log.jsonl"

if [ ! -f "$LOG_FILE" ]; then
  echo "No usage log found at $LOG_FILE"
  echo "Enable the skill-usage-tracker.sh hook first."
  exit 1
fi

TOTAL=$(wc -l < "$LOG_FILE" | tr -d ' ')
echo "=== Skill Usage Report ==="
echo "Total invocations: $TOTAL"
echo ""

# Top 10 most-used skills
echo "--- Top 10 Skills ---"
grep -o '"skill":"[^"]*"' "$LOG_FILE" \
  | sed 's/"skill":"//;s/"//' \
  | sort | uniq -c | sort -rn \
  | head -10 \
  | awk '{printf "  %4d  %s\n", $1, $2}'
echo ""

# Skills not triggered in 7+ days
echo "--- Stale Skills (no invocation in 7+ days) ---"
CUTOFF=$(date -u -v-7d +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date -u -d "7 days ago" +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || echo "")
if [ -n "$CUTOFF" ]; then
  # Get all skills and their last invocation
  grep -o '"skill":"[^"]*","session' "$LOG_FILE" \
    | sed 's/"skill":"//;s/","session//' \
    | sort -u | while read -r skill; do
      LAST_TS=$(grep "\"skill\":\"${skill}\"" "$LOG_FILE" | tail -1 | grep -o '"ts":"[^"]*"' | sed 's/"ts":"//;s/"//')
      if [ -n "$LAST_TS" ] && [[ "$LAST_TS" < "$CUTOFF" ]]; then
        echo "  $skill (last: $LAST_TS)"
      fi
    done
else
  echo "  (date calculation not supported on this platform)"
fi
echo ""

# Daily usage (last 7 days)
echo "--- Daily Usage (last 7 days) ---"
for i in $(seq 0 6); do
  DAY=$(date -u -v-${i}d +"%Y-%m-%d" 2>/dev/null || date -u -d "$i days ago" +"%Y-%m-%d" 2>/dev/null || continue)
  COUNT=$(grep -c "\"ts\":\"${DAY}" "$LOG_FILE" 2>/dev/null || echo "0")
  printf "  %s  %3d invocations\n" "$DAY" "$COUNT"
done
echo ""

# Unique sessions
SESSIONS=$(grep -o '"session":"[^"]*"' "$LOG_FILE" | sort -u | wc -l | tr -d ' ')
echo "Unique sessions: $SESSIONS"
echo "=== End Report ==="
