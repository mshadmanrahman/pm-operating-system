#!/usr/bin/env bash
# check-pr-status.sh - Get structured status for a single PR
# Usage: check-pr-status.sh <owner/repo> <pr-number>
#
# Outputs JSON with CI status, review status, merge conflict status,
# and time since last update.

set -euo pipefail

REPO="${1:?Usage: check-pr-status.sh <owner/repo> <pr-number>}"
PR_NUMBER="${2:?Usage: check-pr-status.sh <owner/repo> <pr-number>}"

# Validate PR number is numeric
if ! [[ "$PR_NUMBER" =~ ^[0-9]+$ ]]; then
  echo '{"error": "PR number must be numeric"}' >&2
  exit 1
fi

# Fetch PR data in a single API call
pr_data=$(gh pr view "$PR_NUMBER" --repo "$REPO" --json \
  title,state,mergeable,mergeStateStatus,headRefOid,baseRefName,headRefName,\
  updatedAt,createdAt,reviews,reviewRequests,statusCheckRollup,number,url \
  2>&1) || {
  echo "{\"error\": \"Failed to fetch PR #$PR_NUMBER from $REPO\", \"details\": \"$pr_data\"}"
  exit 1
}

# Extract fields
title=$(echo "$pr_data" | jq -r '.title // "unknown"')
state=$(echo "$pr_data" | jq -r '.state // "unknown"')
mergeable=$(echo "$pr_data" | jq -r '.mergeable // "UNKNOWN"')
merge_state=$(echo "$pr_data" | jq -r '.mergeStateStatus // "UNKNOWN"')
head_sha=$(echo "$pr_data" | jq -r '.headRefOid // ""')
base_ref=$(echo "$pr_data" | jq -r '.baseRefName // "main"')
head_ref=$(echo "$pr_data" | jq -r '.headRefName // ""')
updated_at=$(echo "$pr_data" | jq -r '.updatedAt // ""')
url=$(echo "$pr_data" | jq -r '.url // ""')

# CI status: count pass/fail/pending from statusCheckRollup
ci_total=$(echo "$pr_data" | jq '[.statusCheckRollup[]?] | length')
ci_passing=$(echo "$pr_data" | jq '[.statusCheckRollup[]? | select(.conclusion == "SUCCESS" or .conclusion == "NEUTRAL" or .conclusion == "SKIPPED")] | length')
ci_failing=$(echo "$pr_data" | jq '[.statusCheckRollup[]? | select(.conclusion == "FAILURE" or .conclusion == "CANCELLED" or .conclusion == "TIMED_OUT" or .conclusion == "ACTION_REQUIRED")] | length')
ci_pending=$(echo "$pr_data" | jq '[.statusCheckRollup[]? | select(.conclusion == "" or .conclusion == null or .status == "IN_PROGRESS" or .status == "QUEUED" or .status == "PENDING")] | length')

# Failed check names and contexts
ci_failed_checks=$(echo "$pr_data" | jq -c '[.statusCheckRollup[]? | select(.conclusion == "FAILURE" or .conclusion == "CANCELLED" or .conclusion == "TIMED_OUT") | {name: .name, conclusion: .conclusion, detailsUrl: .detailsUrl}]')

# Review status
reviews_approved=$(echo "$pr_data" | jq '[.reviews[]? | select(.state == "APPROVED")] | length')
reviews_changes_requested=$(echo "$pr_data" | jq '[.reviews[]? | select(.state == "CHANGES_REQUESTED")] | length')
reviews_pending=$(echo "$pr_data" | jq '[.reviewRequests[]?] | length')

# Determine overall review state
if [ "$reviews_changes_requested" -gt 0 ]; then
  review_state="CHANGES_REQUESTED"
elif [ "$reviews_approved" -gt 0 ]; then
  review_state="APPROVED"
elif [ "$reviews_pending" -gt 0 ]; then
  review_state="PENDING"
else
  review_state="NONE"
fi

# Determine overall CI state
if [ "$ci_total" -eq 0 ]; then
  ci_state="NONE"
elif [ "$ci_failing" -gt 0 ]; then
  ci_state="FAILING"
elif [ "$ci_pending" -gt 0 ]; then
  ci_state="PENDING"
else
  ci_state="PASSING"
fi

# Time since last update (seconds)
if [ -n "$updated_at" ]; then
  if command -v gdate &>/dev/null; then
    updated_epoch=$(gdate -d "$updated_at" +%s 2>/dev/null || date -j -f "%Y-%m-%dT%H:%M:%SZ" "$updated_at" +%s 2>/dev/null || echo 0)
  else
    updated_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$updated_at" +%s 2>/dev/null || date -d "$updated_at" +%s 2>/dev/null || echo 0)
  fi
  now_epoch=$(date +%s)
  seconds_since_update=$(( now_epoch - updated_epoch ))
else
  seconds_since_update=-1
fi

# Output structured JSON
jq -n \
  --argjson number "$PR_NUMBER" \
  --arg title "$title" \
  --arg url "$url" \
  --arg state "$state" \
  --arg ci_state "$ci_state" \
  --argjson ci_total "$ci_total" \
  --argjson ci_passing "$ci_passing" \
  --argjson ci_failing "$ci_failing" \
  --argjson ci_pending "$ci_pending" \
  --argjson ci_failed_checks "$ci_failed_checks" \
  --arg review_state "$review_state" \
  --argjson reviews_approved "$reviews_approved" \
  --argjson reviews_changes_requested "$reviews_changes_requested" \
  --argjson reviews_pending "$reviews_pending" \
  --arg mergeable "$mergeable" \
  --arg merge_state "$merge_state" \
  --arg head_sha "$head_sha" \
  --arg base_ref "$base_ref" \
  --arg head_ref "$head_ref" \
  --arg updated_at "$updated_at" \
  --argjson seconds_since_update "$seconds_since_update" \
  '{
    number: $number,
    title: $title,
    url: $url,
    state: $state,
    ci: {
      state: $ci_state,
      total: $ci_total,
      passing: $ci_passing,
      failing: $ci_failing,
      pending: $ci_pending,
      failed_checks: $ci_failed_checks
    },
    reviews: {
      state: $review_state,
      approved: $reviews_approved,
      changes_requested: $reviews_changes_requested,
      pending: $reviews_pending
    },
    merge: {
      mergeable: $mergeable,
      merge_state: $merge_state
    },
    branch: {
      head_sha: $head_sha,
      base_ref: $base_ref,
      head_ref: $head_ref
    },
    updated_at: $updated_at,
    seconds_since_update: $seconds_since_update
  }'
