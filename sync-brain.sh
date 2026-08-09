#!/usr/bin/env bash
# Auto-Sync Obsidian Brain -> GitHub (hermes-obsidian-brain-gamedev)
cd "$(dirname "$0")" || exit 1

# Änderungen erfassen
if ! git diff --quiet || ! git diff --cached --quiet; then
  git add -A
  git commit -m "sync: brain update $(date '+%Y-%m-%d %H:%M:%S')"
  git push origin HEAD 2>&1
else
  echo "no changes"
fi
