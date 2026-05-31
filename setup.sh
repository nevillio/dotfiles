#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

echo "Stowing all dotfiles from $DOTFILES_DIR..."

fd -t d --max-depth 1 --exclude '.git' . "$DOTFILES_DIR" | sed 's|/$||' | while read -r dirpath; do
    dir=$(basename "$dirpath")
    echo "Stowing: $dir"
    if stow "$dir" 2>&1; then
        echo "  -> Success"
    else
        echo "  -> Failed (may already be stowed or conflicts exist)"
    fi
done

echo "Done!"
