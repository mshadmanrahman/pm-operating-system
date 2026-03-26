# Agent Coordination

Rules for parallel agents in the same worktree/branch.

## Principles
1. File-level parallelism: different files = no conflict
2. Explicit coordination for shared files
3. Fail fast, report conflicts immediately
4. Humans resolve merge conflicts, never agents

## Rules
- Agents only modify files in their assigned stream (from `{issue}-analysis.md`)
- Check `git status {file}` before modifying shared files
- Atomic commits: one purpose per commit (`Issue #N: description`)
- Pull frequently, commit early and often
- Never use `--force` flags
- Update stream progress files after each significant step

## Conflict Protocol
1. Agent detects conflict
2. Reports: "Conflict detected in {files}"
3. Pauses work
4. Human resolves
5. Agent continues after resolution
