# PPP Template Format

The living document format used in `_product-brain/`. Each project gets one file. Above the `---` line is rewritten on every update. Below the line is append-only.

```markdown
# {Project Name}

**Status:** {Discovery | Planning | In Progress | Blocked | On Hold | Complete}
**Updated:** {date} (from: {meeting name})
**Owner:** {who owns this, default to "you"}

## Current State
{One paragraph: what is this project and where is it right now}

## Progress
- {Completed items, shipped work, resolved issues}
- {Be specific: "Sebastian shared algorithm" not "algorithm discussed"}

## Plans
- {Forward-looking items with owners and dates when known}
- {Commitments made in meetings}

## Problems
- {Blockers, risks, dependencies, escalations}
- {Include who can unblock and urgency level}

## Open Questions
- {Unresolved questions needing investigation}
- {Pending decisions with context on who decides}

---

## Changelog
- **{YYYY-MM-DD}:** {One-line summary from meeting/event}. {Key outcome}.
- **{YYYY-MM-DD}:** {Previous entry. Never edited.}
```

## Rewrite Rules

| Section | Behavior |
|:--------|:---------|
| Current State | Rewrite fully to reflect state after this meeting |
| Progress | Replace with current items. Move completed work to changelog. |
| Plans | Replace with current forward-looking items |
| Problems | Replace. Resolved problems move to changelog with resolution note. |
| Open Questions | Replace. Answered questions move to changelog. |
| Changelog | **APPEND ONLY.** One dated entry per meeting. Never edit old entries. |
| Status | Update if project phase changed |
| Updated | Set to today's date and meeting name |

## Naming Convention

Files live at `_product-brain/{slug}.md`. Slug: lowercase, hyphens, no spaces.

Examples: `heimdall.md`, `kas-bugs.md`, `lead-scoring.md`, `wisebox.md`
