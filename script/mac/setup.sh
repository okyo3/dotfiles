#!/bin/zsh

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/../.." && pwd)"

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# GUI Apps
brew bundle --file="$DOTFILES_DIR/Brewfile"

# mise
curl https://mise.run | sh
