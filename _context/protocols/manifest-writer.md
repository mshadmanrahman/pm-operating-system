# Manifest Writer Protocol

You MUST write structured findings to a manifest file as you work.
This is how the orchestrator tracks your progress without consuming main session context.

## Your Manifest File

Write to the path provided in your task instructions. Format: `_context/manifests/{YYYY-MM-DD}/{task-slug}.jsonl`

## Entry Format

One JSON object per line. Append, never overwrite:

```bash
echo '{"timestamp":"TIMESTAMP","agent":"YOUR_NAME","type":"TYPE","summary":"Short one-liner","detail":"Optional full context","status":"STATUS"}' >> MANIFEST_PATH
```

### Fields

| Field | Required | Description |
|-------|----------|-------------|
| timestamp | Yes | ISO 8601 UTC |
| agent | Yes | Your agent name (from task description) |
| type | Yes | `finding`, `decision`, `followup`, `error` |
| summary | Yes | Under 100 characters |
| detail | No | Full context if summary is insufficient |
| linked_task | No | Task ID if applicable |
| status | Yes | `complete`, `in_progress`, `blocked` |

### Types

- `finding`: Something you discovered
- `decision`: A choice you made and why
- `followup`: Something that needs attention later
- `error`: Something that failed and what was tried

## Rules

1. Write entries AS YOU WORK, not all at the end
2. Keep summaries under 100 characters
3. Use `detail` only when the summary would lose critical context
4. Cap at 10 entries per manifest file
5. Return ONLY a 2-line summary to the orchestrator. Your full output lives in the manifest.

## Example

```bash
echo '{"timestamp":"2026-02-25T14:30:00Z","agent":"research-kevel","type":"finding","summary":"Kevel Decision API supports custom key-value targeting","detail":"The /v2/decisions endpoint accepts targeting objects with custom keys. Docs: dev.kevel.com/reference/decision-api","status":"complete"}' >> _context/manifests/2026-02-25/research-kevel.jsonl
```

## Return Format

When done, return ONLY this to the orchestrator:

```
DONE: {1-line what you accomplished}
MANIFEST: {path to your manifest file}
```
