# DateTime Rule

ALWAYS get real system time. NEVER use placeholders or estimates.

```bash
date -u +"%Y-%m-%dT%H:%M:%SZ"
```

Format: ISO 8601 UTC (`2024-01-15T14:30:45Z`). Use in all frontmatter `created`/`updated`/`last_sync` fields.

Rules:
- Run `date` before writing any file with timestamps
- Preserve original `created`, update `updated` on changes
- Always UTC (the `Z` suffix)
