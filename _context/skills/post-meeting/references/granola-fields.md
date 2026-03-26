# Granola Meeting Object Fields

Key fields available when fetching meetings via Granola MCP tools.

## Discovery Tools

### `list_meetings`
Returns recent meetings. Use when the user doesn't specify which meeting.
- Returns: list of meeting summaries (title, date, participants)
- Default: last 5 meetings

### `query_granola_meetings`
Search meetings by keyword or person name.
- Input: search term (person name, topic, or keyword)
- Returns: matching meetings sorted by recency
- Use for: "post-meeting with Sebastian", "process the ESP sync"

### `get_meeting_transcript`
Full meeting content for a specific meeting.
- Input: meeting ID (from list or query results)
- Returns: complete transcript + structured data

## Key Fields to Extract

| Field | Description | Used For |
|:------|:------------|:---------|
| `title` | Meeting name/subject line | Matching to project, changelog entry |
| `participants` | Attendee list with names | Identifying who said what, attributing decisions |
| `transcript` | Full meeting transcript | Primary source for all extraction |
| `action_items` | Granola-extracted action items | Cross-reference with your own extraction |
| `date` | When the meeting occurred | Changelog dating, staleness checks |
| `duration` | Meeting length | Context (5-min sync vs 60-min deep dive) |
| `notes` | User's manual notes added in Granola | High-signal: user thought these were worth noting |

## Extraction Priority

When processing a transcript, extract in this order:

1. **Decisions** (highest signal): "We decided...", "Let's go with...", "Agreed that..."
2. **Commitments with owners**: "{Person} will {action} by {date}"
3. **Problems/blockers raised**: "The issue is...", "We're blocked on...", "Risk: ..."
4. **Open questions**: "We need to figure out...", "TBD:", "Question: ..."
5. **Progress updates**: "We shipped...", "Done:", "Completed..."

## Tips

- Granola's own `action_items` are useful but often miss nuance. Always scan the full transcript.
- If `notes` field exists, treat it as highest priority: the user manually flagged this content.
- Participants list helps with attribution: "Ric suggested..." not "someone mentioned..."
- Duration context matters: a 10-minute standup vs a 60-minute deep dive produce different depth of extraction.
