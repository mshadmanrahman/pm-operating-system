# Meeting Prep Output Template

Render directly in conversation unless the user requests a file.

```markdown
# Meeting Prep: {Person or Topic}
**For:** {Meeting name if known} | **When:** {Time if known}

## Last 3 Interactions
1. **{YYYY-MM-DD}** ({Granola/Slack/Jira}): {1-2 sentence summary}
2. **{YYYY-MM-DD}** ({source}): {1-2 sentence summary}
3. **{YYYY-MM-DD}** ({source}): {1-2 sentence summary}

## They're Waiting On You
- {Action item you owe them} (source: {Jira/Slack/meeting})
- {Action item you owe them} (source: {source})

_(If none found: "Nothing outstanding found.")_

## You're Waiting On Them
- {Action item they owe you} (source: {source})
- {Action item they owe you} (source: {source})

_(If none found: "Nothing outstanding found.")_

## Their Current Focus
- {Active Jira issue or PR with link}
- {What they mentioned working on in Slack/meetings}

## Open Threads
- {Unresolved Slack thread: channel, topic, date}
- {Pending email chain: subject, last activity}
- {Blocked Jira issue: key, blocker reason}

## Suggested Talking Points
1. {Based on action items owed in either direction}
2. {Based on unresolved threads or stale items}
3. {Based on upcoming deadlines or decisions from calendar/Jira}
```

## Section Rules

| Section | Include When | Skip When |
|:--------|:------------|:----------|
| Last 3 Interactions | Always | Never |
| They're Waiting On You | Action items found | Show "Nothing outstanding" |
| You're Waiting On Them | Action items found | Show "Nothing outstanding" |
| Their Current Focus | Person-based prep | Topic-based prep (replace with "Current State") |
| Open Threads | Unresolved items exist | No open items found |
| Suggested Talking Points | Always | Never (infer from available data) |

## Topic-Based Variant

For topic prep, replace person-specific sections:

- "Their Current Focus" becomes **"Current State"** (Jira epic status, latest Confluence spec, recent PRs)
- "They're Waiting On You" becomes **"Your Open Items"** (your assigned tickets on this topic)
- "You're Waiting On Them" becomes **"Pending from Others"** (tickets assigned to others)
