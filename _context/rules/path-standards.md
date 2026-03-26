# Path Standards

ALWAYS use relative paths. NEVER expose absolute paths with usernames in public docs, GitHub Issues, or code comments.

```
CORRECT: internal/auth/server.go, ../project-name/src/api.ts
WRONG:   /Users/username/project/internal/auth/server.go
```

Rules:
- Project files: relative to project root (`src/api/users.ts`)
- Cross-project: relative sibling (`../project-name/path`)
- Before GitHub sync: strip absolute paths with `sed "s|/Users/[^/]*/[^/]*/|../|g"`
- If absolute path leaked publicly: edit immediately, clean git history if needed
