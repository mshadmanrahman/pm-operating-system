#!/bin/bash
# Session-end learning hook
# Captures key patterns from the session and saves to memory
# Lightweight: runs only once at session end, not on every tool call

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
HANDOFF_DIR="$PROJECT_ROOT/_context/handoffs"
DATE=$(date -u +"%Y-%m-%d")
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Create handoff directory if needed
mkdir -p "$HANDOFF_DIR" 2>/dev/null

# Create a lightweight session marker for resume
cat > "$HANDOFF_DIR/latest-session.md" << EOF
---
date: $TIMESTAMP
status: completed
---
# Session Handoff: $DATE

Session completed at $TIMESTAMP.
Use /handoff-doc for full context capture, or read this file to resume.
EOF

# Log hook execution (optional, for debugging)
mkdir -p "$PROJECT_ROOT/.claude" 2>/dev/null
echo "Session learning hook ran at $TIMESTAMP" >> "$PROJECT_ROOT/.claude/session-log.txt"
