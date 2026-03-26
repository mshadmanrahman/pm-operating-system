# Project Health Signals

How to classify each project when generating the Pulse dashboard.

## Health Assessment Matrix

### Needs Attention (Red)

Trigger if ANY of these are true:

| Signal | How to Detect |
|:-------|:-------------|
| **Unresolved problems** | Problems section has items with no corresponding Plan to address them |
| **Stale project** | `Updated` date is 7+ days old AND status is not "On Hold" or "Complete" |
| **Overdue commitments** | Plans section mentions dates that have passed |
| **Explicit escalation** | Problems section contains words: "escalation", "urgent", "blocked", "critical" |
| **Empty plans** | Project has problems but Plans section is empty or only has vague items |

### Active (Green)

All of these must be true:

| Signal | How to Detect |
|:-------|:-------------|
| **Recently updated** | `Updated` date within last 7 days |
| **Plans in motion** | Plans section has specific, actionable items |
| **No critical blockers** | Problems section is empty OR all problems have corresponding plans |
| **Status is active** | Status is "In Progress", "Planning", or "Discovery" |

### On Hold (Yellow)

| Signal | How to Detect |
|:-------|:-------------|
| **Explicit status** | Status field says "On Hold" |
| **Stale but intentional** | Updated 7+ days ago AND last changelog entry explains the pause |

### Complete (Blue)

| Signal | How to Detect |
|:-------|:-------------|
| **Explicit status** | Status field says "Complete" |
| **Empty plans** | Plans section is empty or says "None" with Complete status |

## Staleness Detection

```
WARNING threshold: 7 days without update (status not On Hold/Complete)
ALERT threshold: 14 days without update
```

Flag stale projects:
```
{project} hasn't been updated since {date}. Still active? Consider running /post-meeting or updating manually.
```

## Priority Sorting

Within "Needs Attention", sort by:
1. Explicit escalations first
2. Stalest projects (longest since update)
3. Projects with overdue commitments
4. Projects with unaddressed problems

## Edge Cases

- **New project, no history**: Classify as Active if it has Plans. Skip health judgment.
- **Project with only changelog**: Stale. Needs attention to fill in current state.
- **Multiple problems, some resolved**: Count only unresolved problems for health assessment.
