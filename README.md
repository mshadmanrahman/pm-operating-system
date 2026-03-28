# PM Operating System for Claude Code

An opinionated workflow system that restructures how product managers work in an agent-native world.

Not a prompt library. Not a skill pack. A **practice** that compounds over time.

## What this is

A complete Claude Code configuration that gives you:

- **Zero cold-start sessions**: Memory and handoffs mean you never re-explain context
- **PM workflows as commands**: `/meeting-prep`, `/pulse`, `/weekly-status`, `/post-meeting`
- **Living project documents**: Product brain docs that update after every meeting
- **Agent orchestration**: 9 specialized agents for planning, code review, testing, security
- **10 coding rules**: Consistent standards across TypeScript, Python, Git, and testing
- **6 automation hooks**: Session learning, skill tracking, autonomous loops
- **13 slash commands**: From `/plan` to `/generate-slides`

## What it includes

| Category | Count | Examples |
|----------|-------|---------|
| PM Skills | 16 | meeting-prep, pulse, post-meeting, weekly-status, deep-context |
| Agents | 9 | planner, code-reviewer, tdd-guide, security-reviewer, parallel-worker |
| Rules | 10 | typescript-style, git-parallel-work, agent-coordination |
| Commands | 13 | plan, verify, tdd, generate-web-diagram, diff-review |
| Hooks | 6 | session-learn, autonomous-loop, skill-drift-check |
| Protocols | 1 | manifest-writer (sub-agent communication) |

## Quick start

```bash
# Clone the repo
git clone https://github.com/mshadmanrahman/pm-operating-system.git

# Install into your workspace
cd your-workspace
bash /path/to/pm-operating-system/install.sh .

# Start Claude Code
claude

# Try your first command
/pulse
```

## The philosophy

Read [docs/PRACTICE.md](docs/PRACTICE.md) for the full system philosophy. The short version:

1. **Context compounds.** Memory and handoffs accumulate institutional knowledge.
2. **Workflows, not prompts.** Each skill encodes a complete, repeatable workflow.
3. **Decisions are traceable.** Product brain docs create a living record.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed
- Any project directory (works with any tech stack)
- Optional: MCP integrations (Gmail, Slack, Jira, GitHub) for richer context

## Documentation

- [PRACTICE.md](docs/PRACTICE.md): The system philosophy and "why"
- [SESSION-LIFECYCLE.md](docs/SESSION-LIFECYCLE.md): How sessions work
- [CUSTOMIZATION.md](docs/CUSTOMIZATION.md): Adding your own skills, MCPs, and rules

## Who this is for

Senior PMs, product leads, and engineering managers who use Claude Code daily and want their AI workflow to compound over time instead of resetting every session.

## Stay in the Loop

New skills, workflow patterns, and tips for AI-native product management.

**[Subscribe for updates](https://claudecodeguide.dev)** — no spam, unsubscribe anytime.

## Premium Skill Packs (Coming Q2 2026)

The free system covers every PM. Premium packs go deeper for specific roles:

| Pack | Skills | For who | Price |
|------|--------|---------|-------|
| Growth PM Pack | 7 | Experiment design, funnel analysis, retention | $39 |
| Platform PM Pack | 6 | API reviews, DX audits, breaking changes | $39 |
| EM Pack | 7 | 1:1 prep, team health, perf reviews, hiring | $39 |
| Complete Bundle | 20 + playbook | All packs + PM & AI Playbook PDF | $149 |

**[Get early access + 30% launch discount](https://claudecodeguide.dev)** — join the waitlist.

## Contributing

Found a bug? Have a skill idea? Open an issue or PR. All contributions welcome.

## License

MIT
