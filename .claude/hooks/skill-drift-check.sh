#!/bin/bash
# Skill drift detector: finds skills that haven't been modified in 90+ days
# Run manually or on a schedule: ~/.claude/hooks/skill-drift-check.sh

echo "=== Skill Drift Report ==="
echo "Skills not modified in 90+ days:"
echo ""

STALE=0

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

for dir in "$PROJECT_ROOT/_context/skills/"*/; do
  skill=$(basename "$dir")
  skill_file="$dir/SKILL.md"
  if [ -f "$skill_file" ]; then
    # Get days since last modification
    mod_epoch=$(stat -f '%m' "$skill_file" 2>/dev/null)
    now_epoch=$(date +%s)
    days_old=$(( (now_epoch - mod_epoch) / 86400 ))
    if [ "$days_old" -gt 90 ]; then
      echo "  $skill (${days_old}d stale)"
      STALE=$((STALE + 1))
    fi
  fi
done

for dir in "$HOME/.claude/skills/"*/; do
  skill=$(basename "$dir")
  skill_file="$dir/SKILL.md"
  if [ -f "$skill_file" ]; then
    mod_epoch=$(stat -f '%m' "$skill_file" 2>/dev/null)
    now_epoch=$(date +%s)
    days_old=$(( (now_epoch - mod_epoch) / 86400 ))
    if [ "$days_old" -gt 90 ]; then
      echo "  [ECC] $skill (${days_old}d stale)"
      STALE=$((STALE + 1))
    fi
  fi
done

echo ""
if [ "$STALE" -eq 0 ]; then
  echo "All skills modified within 90 days."
else
  echo "$STALE stale skills found."
  echo "Review: delete unused ones or touch SKILL.md to reset the clock."
fi
