# Customization Guide

The PM Operating System is opinionated but extensible. Here's how to make it yours.

## Adding MCP Integrations

Skills like `meeting-prep`, `pulse`, and `weekly-status` work best with MCP servers connected. Add them to your `.mcp.json`:

```json
{
  "mcpServers": {
    "gmail": { "command": "...", "args": ["..."] },
    "slack": { "command": "...", "args": ["..."] },
    "jira": { "command": "...", "args": ["..."] },
    "github": { "command": "...", "args": ["..."] }
  }
}
```

Skills gracefully degrade without MCPs. `meeting-prep` without Gmail just skips the email context.

## Adding Your Own Skills

Create a new directory in `_context/skills/{skill-name}/` with a `SKILL.md`:

```markdown
---
name: my-custom-skill
description: One-line description for trigger matching
triggers:
  - "keyword1"
  - "keyword2"
---

# My Custom Skill

Instructions for Claude when this skill activates.
```

## Customizing Rules

Rules in `_context/rules/` define coding standards and workflow patterns. Edit them to match your team's conventions:

- `typescript-style.md`: TypeScript/JavaScript patterns
- `python-style.md`: Python patterns
- `github-operations.md`: Git workflow and PR patterns
- `standard-patterns.md`: Error handling, output formats

## Configuring Notifications

The notification hook is opt-in. Set `NOTIFICATION_URL` in your environment to enable push notifications:

```bash
export NOTIFICATION_URL="https://your-notification-service.com/api/push"
```

The hook sends a POST with `{ "title": "...", "body": "..." }`. Works with ntfy.sh, Pushover, or any webhook.

## Customizing the Product Brain

The `_product-brain/` directory holds living project documents. Create one per project:

```markdown
# Project Name

**Status:** Discovery / In Progress / Shipped / Paused
**Owner:** Your Name

## Vision
What this project is and why it matters.

## Current State
What's happening right now.

## Problems
What's blocking progress.

## Plans
What's next.
```

The `/pulse` skill reads all files in `_product-brain/` to generate your cross-project dashboard.

## Adjusting the Session Lifecycle

Edit `.claude/CLAUDE.md` to change:
- Which memory types to prioritize
- Handoff requirements (strict vs relaxed)
- Agent orchestration preferences
- Communication style directives

## Adding New Agents

Create a `.md` file in `_context/agents/` following this pattern:

```markdown
# Agent Name

## Purpose
What this agent does.

## When to Use
Triggers and scenarios.

## Instructions
Detailed instructions for the agent's behavior.
```

Reference the agent in your CLAUDE.md orchestration section.
