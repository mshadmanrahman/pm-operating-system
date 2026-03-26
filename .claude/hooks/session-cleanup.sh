#!/bin/bash
# Post-session cleanup: move stray screenshots to _scratch/screenshots/
# and clean old files from _scratch/

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
SCRATCH="$PROJECT_ROOT/_scratch"

mkdir -p "$SCRATCH/screenshots" 2>/dev/null

# Move any stray screenshots from project root to _scratch/screenshots/
find "$PROJECT_ROOT" -maxdepth 1 \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) 2>/dev/null | while read f; do
  mv "$f" "$SCRATCH/screenshots/" 2>/dev/null
done

# Clean screenshots older than 7 days
find "$SCRATCH/screenshots/" -type f -mtime +7 -delete 2>/dev/null

# Clean visualizations older than 30 days
find "$SCRATCH/visualizations/" -type f -mtime +30 -delete 2>/dev/null

# Clean empty playground experiments older than 14 days
find "$SCRATCH/playground/" -maxdepth 1 -type d -empty -mtime +14 -delete 2>/dev/null
