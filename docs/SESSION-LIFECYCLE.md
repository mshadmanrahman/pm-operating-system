# Session Lifecycle

## Starting a Session

Every session begins with context resumption. The system reads:

1. **Memory** (`MEMORY.md`): Index of persistent knowledge about you, your projects, your preferences
2. **Latest handoff** (`_context/handoffs/`): What happened last session, what's next, key decisions
3. **Product brain** (`_product-brain/`): Living project docs with current state

This eliminates the "let me re-explain everything" tax.

### How memory works

Memory files are organized by type:
- **user**: Your role, goals, preferences (tailors behavior to you)
- **feedback**: Corrections and confirmations (prevents repeating mistakes)
- **project**: Active work, timelines, stakeholders (non-obvious context)
- **reference**: Where to find things in external systems

Memory is NOT for: code patterns (read the code), git history (use git log), debugging solutions (the fix is in the code).

## During a Session

### The orchestration workflow

1. **Plan mode for non-trivial work** (3+ steps or architectural decisions). If something goes sideways, stop and re-plan.
2. **Sub-agents for parallel work.** One task per agent. Keeps main context clean.
3. **Self-improvement loop.** After any correction, capture the lesson. Write rules to prevent the same mistake.
4. **Verify before marking done.** Run tests, check logs, diff behavior.

### Using skills

Skills encode complete PM workflows:

| Skill | When to use |
|-------|-------------|
| `/meeting-prep {person}` | Before any meeting. Pulls context from connected systems. |
| `/post-meeting` | After any meeting. Extracts insights, updates product brain. |
| `/pulse` | Morning check-in. What needs attention across all projects. |
| `/weekly-status` | Friday afternoon. Auto-generated accomplishment report. |
| `/deep-context {topic}` | When you need to research something across all sources. |
| `/plan` | Before starting any non-trivial implementation. |

### Using agents

Agents handle focused tasks without polluting your main context:

| Agent | Purpose |
|-------|---------|
| `planner` | Break down complex work into phases |
| `code-reviewer` | Review code immediately after writing it |
| `tdd-guide` | Enforce test-driven development |
| `parallel-worker` | Run multiple tasks simultaneously in git worktrees |
| `security-reviewer` | Catch vulnerabilities before they ship |

## Ending a Session

**Mandatory before finishing any session:**

1. If work is in-progress or non-trivial decisions were made: write a handoff to `_context/handoffs/YYYY-MM-DD-{topic}.md`
2. If corrections or surprises occurred: save to memory files
3. Minimum handoff content: what was done, what's next, key decisions or blockers

The `session-learn` hook auto-captures patterns. The `session-cleanup` hook tidies artifacts. But YOU must capture the reasoning and decisions (hooks can't do that).

### Handoff template

```markdown
# {Topic} - {Date}

## What was done
- Bullet points of completed work

## Key decisions
- Decision and rationale

## What's next
- Immediate next steps
- Blockers or dependencies

## Open questions
- Things that need answers
```

## The Compound Effect

After 1 week: sessions start faster, less re-explanation.
After 1 month: memory captures your working style, common corrections stop.
After 3 months: the system knows your projects, people, preferences. It anticipates what you need.

This is not a chatbot getting smarter. It's an operating system learning your practice.
