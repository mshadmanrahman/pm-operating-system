# Handoff: {Task Title}

**Created:** {ISO timestamp}
**From:** {Source: "Cowork task", "Claude mobile", "Claude web", "Claude Code"}
**Status:** {In progress | Blocked | Ready for next step}

## Context

{2-4 sentences: What were we working on? Why does it matter? Include enough background that a fresh session can pick this up cold.}

## Decisions Made

- {Decision}: {reasoning}. See `{file path}`.
- {Decision}: {reasoning}.

## Current State

- {What exists right now}
- {Files created or modified}
- {Where things stand: percentage complete, what's working, what's not}

## Open Questions

- {Unresolved question needing investigation}
- {Decision pending: who decides, what's needed to decide}

## Next Steps

1. {Most important action, specific enough to execute immediately}
2. {Second action}
3. {Third action}

## Files Referenced

| File | Description |
|:-----|:------------|
| `{relative path}` | {One-line description} |
| `{relative path}` | {One-line description} |

## Manifests

{Include if `.claude/manifests/{date}/*.jsonl` files exist}

- `.claude/manifests/{date}/{agent}.jsonl` - {N} entries, key finding: {summary}

---

## Quick Handoff Variant

For fast handoffs when the user is in a hurry, use this instead:

```markdown
# Quick Handoff: {Title}
**Status:** {status}
**Resume with:** {single most important next action}
**Key files:** {comma-separated list}
**Manifests:** {list manifest paths if any}
```

## Rules

- Under 500 words (concise beats complete)
- Relative paths only (no absolute paths with usernames)
- Always include next steps (a handoff without next steps is just a summary)
- No sensitive data (API keys, passwords, tokens)
- Filename: `_context/handoffs/{YYYY-MM-DD}-{slug}.md` (lowercase, hyphens)
