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
    .|..|.git|.gitignore|.config)
      continue
      ;;
  esac

  target="$HOME_DIR/$name"

  ln -sfvn "$file" "$target"
done
