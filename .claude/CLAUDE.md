# CLAUDE.md - PM Operating System

Multi-project workspace. Read `_context/identity.md` for folder map if present.

Skills: `_context/skills/`. Load on demand by trigger.
Protocols: `_context/protocols/` (injection templates for sub-agents).
Agents: `_context/agents/`. Read each `.md` for description.
Rules: `_context/rules/` (coding standards + workflow patterns).
Commands: `.claude/commands/` (slash commands).

## Session Lifecycle

**Starting**: Read MEMORY.md. Check `_context/handoffs/` for latest handoff. Resume context.
**During**: Use memory system for learnings. Use skills and agents for workflows.
**Ending**: MANDATORY before finishing any session:
1. If work is in-progress or non-trivial decisions were made: write a handoff to `_context/handoffs/YYYY-MM-DD-{topic}.md`
2. If corrections or surprises occurred: save to memory files
3. Minimum handoff: what was done, what's next, any key decisions or blockers

## Communication Preferences

- Direct, no fluff. Skip preambles. Just help.
- Lead with recommendations, not option lists.
- Structured output: headings, bullets, numbered steps, tables, checklists.
- Production-ready: code/specs/artifacts should be shippable as-is.
- Actionability first: concrete next steps over theory.

## Orchestration Workflow

1. **Plan Mode Default**: Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions). If something goes sideways, STOP and re-plan immediately.
2. **Sub-agent Strategy**: Use sub-agents liberally to keep main context clean. One task per sub-agent. Offload research, exploration, parallel analysis.
3. **Self-Improvement Loop**: After ANY correction, capture the lesson in memory. Write rules to prevent the same mistake.
4. **Verification Before Done**: Never mark complete without proving it works. Run tests, check logs, diff behavior. "Would a staff engineer approve this?"
5. **Demand Elegance (Balanced)**: For non-trivial changes, pause and ask "is there a more elegant way?" Skip for simple, obvious fixes.
6. **Autonomous Bug Fixing**: Just fix it. Point at logs, errors, failing tests, then resolve them. Zero hand-holding.

## Product Brain

Living project documents live in `_product-brain/`. Each project has one file with: vision, current state, progress, plans, problems, open questions, and a changelog.

Key skills that interact with the product brain:
- `/post-meeting`: Updates the relevant project doc after a meeting
- `/pulse`: Reads all project docs and generates a cross-project dashboard
- `/new-project`: Creates a new product brain doc from template

## Memory System

Memory persists across sessions in the memory directory. Types:
- **user**: Role, goals, preferences (tailors behavior to you)
- **feedback**: Corrections and confirmations (prevents repeating mistakes)
- **project**: Active work context (non-obvious decisions, timelines)
- **reference**: Where to find things in external systems

Do NOT save to memory: code patterns, git history, debugging solutions, ephemeral task details.
