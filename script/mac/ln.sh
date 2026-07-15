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

    if [ "$name" = "herdr" ]; then
      mkdir -p "$target"
      ln -sfvn "$dir/config.toml" "$target/config.toml"
      continue
    fi

    ln -sfvn "$dir" "$target"
  done
fi

# -----------------------------
# top-level dotfiles
# -----------------------------
for file in "$DOTFILES_DIR"/.*; do
  name=$(basename "$file")

  case "$name" in
    .|..|.git|.gitignore|.config|.ai)
      continue
      ;;
  esac

  target="$HOME_DIR/$name"

  ln -sfvn "$file" "$target"
done

# -----------------------------
# AI Agents
# -----------------------------
AGENTS_SRC="$DOTFILES_DIR/.ai/AGENTS.md"

# Codex
mkdir -p "$HOME_DIR/.codex"
ln -sfvn "$AGENTS_SRC" "$HOME_DIR/.codex/AGENTS.md"

# Kiro CLI (steering file)
mkdir -p "$HOME_DIR/.kiro/steering"
ln -sfvn "$AGENTS_SRC" "$HOME_DIR/.kiro/steering/AGENTS.md"
