# Systems Checklist for Meeting Prep

Each system to search, what MCP tool to use, and what to look for.

## Person-Based Prep (1:1s, syncs)

| System | MCP Tool | Query Pattern | What to Extract |
|:-------|:---------|:-------------|:----------------|
| **Jira** | `searchJiraIssuesUsingJql` | `assignee = "{person}" OR reporter = "{person}" AND updated >= -14d ORDER BY updated DESC` | Active issues, recent transitions, blockers |
| **Confluence** | `searchConfluenceUsingCql` | `contributor = "{person}" AND lastModified > now("-14d")` | Pages they've edited, specs in progress |
| **Slack** | `slack_search_public_and_private` | Person name or handle | Recent threads, open conversations, decisions |
| **GitHub** | `search_pull_requests` | Author filter for person | Open PRs, recently merged, review requests |
| **Granola** | `query_granola_meetings` | Person name | Last meeting transcript, action items given |
| **Gmail** | `gmail_search_messages` | `from:{email} OR to:{email} newer_than:14d` | Email threads, pending responses |
| **Obsidian** | Direct vault search | Person name in notes | Meeting notes mentioning them, decisions recorded |

## Topic-Based Prep (product syncs, reviews)

| System | MCP Tool | Query Pattern | What to Extract |
|:-------|:---------|:-------------|:----------------|
| **Jira** | `searchJiraIssuesUsingJql` | `text ~ "{topic}" AND updated >= -30d ORDER BY updated DESC` | Related tickets, epic status, sprint progress |
| **Confluence** | `searchConfluenceUsingCql` | `text ~ "{topic}" AND lastModified > now("-30d")` | Specs, RFCs, decision logs |
| **Slack** | `slack_search_public_and_private` | Topic keywords | Discussions, decisions, unresolved debates |
| **GitHub** | `search_code` or `search_pull_requests` | Topic keywords | Code changes, architectural decisions |
| **Granola** | `query_granola_meetings` | Topic name | Previous meetings on this topic |
| **Gmail** | `gmail_search_messages` | `subject:{topic} newer_than:30d` | External stakeholder threads |
| **Google Calendar** | `gcal_list_events` | Filter by title/attendees | Upcoming related meetings, recurring cadence |

## Search Order

Run all searches in parallel. But if you must prioritize (e.g., rate limits):

1. **Granola** (last meeting is the most relevant context)
2. **Jira** (current work state)
3. **Slack** (recent informal decisions)
4. **Confluence** (formal documentation)
5. **GitHub** (code-level context)
6. **Gmail** (external threads)
7. **Obsidian** (personal notes)

| BRP | "Big Room Planning" |
| FOS | "Field of Study" |
| AdOps | "Kevel", "Featured Listings", "Heimdall" |
