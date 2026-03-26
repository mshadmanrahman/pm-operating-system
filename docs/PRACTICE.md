# The Practice

This is not a skill pack. It's a way of working.

## The Problem

Every PM opens Claude Code the same way: blank context, cold start, type a question, get an answer, close the tab. Next session, start from zero. Context evaporates. Decisions are untraceable. The AI is powerful but stateless.

You end up spending 30% of every session re-explaining who you are, what you're working on, and what happened last time.

## The System

The PM Operating System restructures how product management operates when AI agents are native to your workflow. Three principles:

### 1. Context Compounds

Sessions don't start cold. The memory system persists what matters across conversations: who you work with, what projects are active, what decisions were made, what feedback you've received. The handoff protocol captures reasoning and next steps at the end of every session. The next session picks up exactly where you left off.

This isn't "chat history." It's institutional knowledge that gets more valuable over time.

### 2. Workflows, Not Prompts

You don't type "help me prepare for my 1:1 with Sarah." You run `/meeting-prep Sarah` and the system pulls recent interactions, open items, and suggested talking points from across your connected systems. You don't manually check project status. You run `/pulse` and get a unified view of what needs attention across every project.

Each skill encodes a complete workflow, not a clever prompt. The difference: prompts are one-shot. Workflows are repeatable, consistent, and improvable.

### 3. Decisions Are Traceable

The product brain pattern creates living documents for every project. Not static PRDs that rot in Confluence. Living docs that update after every meeting (via `/post-meeting`), surface in your pulse dashboard, and carry forward through handoffs. Six months from now, you can trace why a decision was made, who was in the room, and what the alternatives were.

## The Session Lifecycle

Every session follows the same rhythm:

**Start**: Read memory. Check latest handoff. Resume context. Zero cold start.

**Work**: Use skills and agents. They handle the grunt work (research, analysis, code review, test execution). You make decisions.

**End**: Write a handoff. Capture what was done, what's next, key decisions. The next session (whether it's you tomorrow or a colleague next week) picks up seamlessly.

This lifecycle is enforced by the CLAUDE.md configuration and hooks. It's not optional discipline. It's system architecture.

## The Orchestration Model

For non-trivial work:

1. **Plan first.** Enter plan mode. Align on approach before touching anything.
2. **Delegate liberally.** Sub-agents handle research, exploration, parallel analysis. Your main context stays clean.
3. **Verify before done.** Nothing is complete until it's proven working. Run tests, check logs, diff behavior.
4. **Demand elegance.** For non-trivial changes, pause and ask "is there a more elegant way?" Skip for simple fixes.

## What Changes

| Before | After |
|--------|-------|
| Every session starts cold | Context resumes automatically |
| "Let me explain the project again..." | Memory + handoffs = zero re-explanation |
| Status updates are manual busywork | `/pulse` generates them in seconds |
| Meeting prep is 20 min of tab-switching | `/meeting-prep` synthesizes everything |
| Project decisions are lost in Slack threads | Product brain docs are living, traceable |
| AI is a chatbot you prompt | AI is an operating system you drive |

## Who This Is For

Senior PMs, product leads, and engineering managers who:
- Run 3+ projects simultaneously
- Use Claude Code as a daily tool
- Want their AI workflow to compound over time, not reset every session
- Value systems over hacks

## Who This Is Not For

- People looking for a prompt library
- Teams that need a shared tool (this is a personal operating system)
- PMs who don't use Claude Code yet
