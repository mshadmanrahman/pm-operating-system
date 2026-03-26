# Git Parallel Work (Branches & Worktrees)

## Branches (Default)
```bash
git checkout main && git pull origin main
git checkout -b epic/{name}
git push -u origin epic/{name}
```

## Worktrees (When Needed)
Use worktrees when you need multiple working directories simultaneously.
```bash
git checkout main && git pull origin main
git worktree add ../epic-{name} -b epic/{name}
```

## Common Rules (Both)
- One branch/worktree per epic, not per issue
- Start from updated main
- Commit format: `Issue #{number}: {description}`
- Small, focused, atomic commits
- Pull frequently before pushing

## Merging Back
```bash
git checkout main && git pull origin main
git merge epic/{name}
# Clean up after merge:
git branch -d epic/{name}                    # branch
git worktree remove ../epic-{name}           # worktree (if used)
```

## Conflicts
Human resolves. Agent reports and pauses. Never force-push or auto-resolve.
