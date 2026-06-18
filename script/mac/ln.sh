#!/bin/zsh

set -euo pipefail
setopt nullglob

DOTFILES_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
HOME_DIR="$HOME"

mkdir -p "$HOME_DIR/.config"

# -----------------------------
# .config
# -----------------------------
if [ -d "$DOTFILES_DIR/.config" ]; then
  for dir in "$DOTFILES_DIR/.config"/*; do
    [ -d "$dir" ] || continue

    name=$(basename "$dir")
    target="$HOME_DIR/.config/$name"

    ln -sfvn "$dir" "$target"
  done
fi

# -----------------------------
# top-level dotfiles
# -----------------------------
for file in "$DOTFILES_DIR"/.*; do
  name=$(basename "$file")

  case "$name" in
    .|..|.git|.gitignore|.config|.codex)
      continue
      ;;
  esac

  target="$HOME_DIR/$name"

  ln -sfvn "$file" "$target"
done

# -----------------------------
# Codex
# -----------------------------
if [ -d "$DOTFILES_DIR/.codex" ]; then
  mkdir -p "$HOME_DIR/.codex"
fi

if [ -f "$DOTFILES_DIR/.codex/AGENTS.md" ]; then
  ln -sfvn "$DOTFILES_DIR/.codex/AGENTS.md" "$HOME_DIR/.codex/AGENTS.md"
fi
