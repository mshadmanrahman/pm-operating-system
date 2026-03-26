#!/usr/bin/env bash
# batch-check.sh - List all open PRs by current user with status summary
# Usage: batch-check.sh [owner/repo]
#
# If no repo is provided, detects from git remote origin.
# Outputs JSON array of PR status objects.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Determine repo
if [ -n "${1:-}" ]; then
  REPO="$1"
else
  remote_url=$(git remote get-url origin 2>/dev/null || echo "")
  if [ -z "$remote_url" ]; then
    echo '{"error": "No repo specified and no git remote origin found"}' >&2
    exit 1
  fi
  REPO=$(echo "$remote_url" | sed 's|.*github.com[:/]||' | sed 's|\.git$||')
fi

# Get current GitHub username
gh_user=$(gh api user --jq '.login' 2>/dev/null || echo "")
if [ -z "$gh_user" ]; then
  echo '{"error": "Could not determine GitHub username. Run: gh auth login"}' >&2
  exit 1
fi

# Fetch all open PRs by current user
prs=$(gh pr list --repo "$REPO" --author "$gh_user" --state open --json number --jq '.[].number' 2>&1) || {
  echo "{\"error\": \"Failed to list PRs from $REPO\", \"details\": \"$prs\"}"
  exit 1
}

if [ -z "$prs" ]; then
  echo "{\"repo\": \"$REPO\", \"user\": \"$gh_user\", \"count\": 0, \"prs\": []}"
  exit 0
fi

# Count PRs
pr_count=$(echo "$prs" | wc -l | tr -d ' ')

# Check each PR (sequentially to avoid rate limits)
results="[]"
checked=0

for pr_num in $prs; do
  checked=$((checked + 1))
  # Write progress to stderr so it does not pollute JSON stdout
  echo "Checking PR #$pr_num ($checked/$pr_count)..." >&2

  pr_status=$("$SCRIPT_DIR/check-pr-status.sh" "$REPO" "$pr_num" 2>/dev/null || echo '{"number": '"$pr_num"', "error": "failed to fetch"}')
  results=$(echo "$results" | jq --argjson pr "$pr_status" '. + [$pr]')
done

# Sort by urgency: failing CI first, then conflicts, then pending, then passing
sorted=$(echo "$results" | jq '
  sort_by(
    if .ci.state == "FAILING" then 0
    elif .merge.mergeable == "CONFLICTING" then 1
    elif .ci.state == "PENDING" then 2
    elif .reviews.state == "CHANGES_REQUESTED" then 3
    elif .reviews.state == "PENDING" then 4
    else 5
    end
  )
')

# Output final JSON
jq -n \
  --arg repo "$REPO" \
  --arg user "$gh_user" \
  --argjson count "$pr_count" \
  --argjson prs "$sorted" \
  '{
    repo: $repo,
    user: $user,
    count: $count,
    prs: $prs
  }'
