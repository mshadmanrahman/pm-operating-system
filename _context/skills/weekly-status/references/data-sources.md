# Data Sources for Weekly Status

Queries and patterns for pulling accomplishment data from each system.

## Jira

### Issues Completed This Week
```
assignee = currentUser() AND status changed to ("Done", "Closed") DURING ("{start}", "{end}") ORDER BY updated DESC
```

### Issues Transitioned (any status change)
```
assignee = currentUser() AND status changed DURING ("{start}", "{end}") ORDER BY updated DESC
```

### Issues Commented On
```
assignee = currentUser() AND updated >= "{start}" ORDER BY updated DESC
```

### Default Configuration
Project key: `INS`. Expand to other projects if the user works across teams.

## GitHub

### PRs Authored This Week
```
search_pull_requests: author:{username} created:{start}..{end}
```

### PRs Merged This Week
```
search_pull_requests: author:{username} merged:{start}..{end}
```

### PRs Reviewed
```
search_pull_requests: reviewed-by:{username} updated:{start}..{end}
```

### Code Commits
```
list_commits: author:{username} since:{start} until:{end}
```

## Confluence

### Pages Created or Updated
```cql
contributor = currentUser() AND lastModified >= "{start}" ORDER BY lastModified DESC
```

### Pages Created (new content only)
```cql
creator = currentUser() AND created >= "{start}" ORDER BY created DESC
```

## Slack

### Messages Sent (search for your own messages)
```
from:me after:{start} before:{end}
```

### Key Channels to Check
- Product team channels
- Project-specific channels
- Direct messages with stakeholders

## Granola / Obsidian

### Meetings This Week
```
query_granola_meetings: date range {start} to {end}
```

### Obsidian Meeting Notes
Search vault for files modified within the date range. Meeting notes typically contain:
- Attendee lists
- Decision records
- Action items assigned

## Weekly Action Scanner

### Cross-Reference File
```
_work/actions/{week-start}-week-actions.md
```

If this file exists, compare assigned actions against completed Jira/GitHub items.
Unmatched actions become the "Carried Forward" section.

## Date Range Calculation

```bash
# Current week: Monday to today
WEEK_START=$(date -v-monday -u +"%Y-%m-%d")
WEEK_END=$(date -u +"%Y-%m-%d")

# Last week
WEEK_START=$(date -v-monday -v-7d -u +"%Y-%m-%d")
WEEK_END=$(date -v-friday -v-7d -u +"%Y-%m-%d")
```

## Deduplication Rules

- Jira issue + linked GitHub PR = count once (use the Jira issue as primary)
- Confluence page updated multiple times = count once with latest timestamp
- Same topic discussed in Slack and meeting = merge into single "Key Decision" entry
