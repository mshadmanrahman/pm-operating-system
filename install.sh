#!/bin/bash
set -euo pipefail

# PM Operating System Installer
# One command to set up the complete PM workflow system for Claude Code

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-.}"

echo ""
echo "  PM Operating System for Claude Code"
echo "  ====================================="
echo ""
echo "  Installing to: $(cd "$TARGET_DIR" 2>/dev/null && pwd || echo "$TARGET_DIR")"
echo ""

# Check prerequisites
if ! command -v claude &> /dev/null; then
    echo "  [!] Claude Code CLI not found."
    echo "      Install: npm install -g @anthropic-ai/claude-code"
    echo ""
    exit 1
fi

# Create target directory if needed
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# Copy the system
echo "  [1/5] Setting up directory structure..."
mkdir -p .claude/commands .claude/hooks
mkdir -p _context/{agents,rules,skills,protocols,handoffs}
mkdir -p _product-brain
mkdir -p docs

echo "  [2/5] Installing CLAUDE.md and configuration..."
cp -n "$SCRIPT_DIR/.claude/CLAUDE.md" .claude/CLAUDE.md 2>/dev/null || echo "        CLAUDE.md already exists, skipping (won't overwrite)"
cp "$SCRIPT_DIR/.claude/settings.json.example" .claude/settings.json.example

echo "  [3/5] Installing agents, rules, and protocols..."
cp -r "$SCRIPT_DIR/_context/agents/"*.md _context/agents/ 2>/dev/null || true
cp -r "$SCRIPT_DIR/_context/rules/"*.md _context/rules/ 2>/dev/null || true
cp -r "$SCRIPT_DIR/_context/protocols/"*.md _context/protocols/ 2>/dev/null || true

echo "  [4/5] Installing skills and commands..."
# Copy skill directories
for skill_dir in "$SCRIPT_DIR/_context/skills/"/*/; do
    skill_name=$(basename "$skill_dir")
    mkdir -p "_context/skills/$skill_name"
    cp -r "$skill_dir"* "_context/skills/$skill_name/" 2>/dev/null || true
done

# Copy commands
cp "$SCRIPT_DIR/.claude/commands/"*.md .claude/commands/ 2>/dev/null || true

# Copy hooks
cp "$SCRIPT_DIR/.claude/hooks/"*.sh .claude/hooks/ 2>/dev/null || true
chmod +x .claude/hooks/*.sh 2>/dev/null || true

echo "  [5/5] Installing docs and templates..."
cp -r "$SCRIPT_DIR/docs/"*.md docs/ 2>/dev/null || true
cp -n "$SCRIPT_DIR/_product-brain/TEMPLATE.md" _product-brain/TEMPLATE.md 2>/dev/null || true
cp -n "$SCRIPT_DIR/_context/handoffs/EXAMPLE-handoff.md" _context/handoffs/EXAMPLE-handoff.md 2>/dev/null || true

echo ""
echo "  Installation complete!"
echo ""
echo "  Next steps:"
echo "  1. cd $(pwd)"
echo "  2. Open CLAUDE.md and customize the Communication Preferences section"
echo "  3. Create your first product brain doc: cp _product-brain/TEMPLATE.md _product-brain/my-project.md"
echo "  4. Start a Claude Code session and try: /pulse"
echo ""
echo "  Optional: Connect MCP integrations for richer context"
echo "  See docs/CUSTOMIZATION.md for details"
echo ""
echo "  Read docs/PRACTICE.md to understand the system philosophy"
echo ""
