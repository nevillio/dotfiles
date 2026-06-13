#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

ROOT_DIRS=("keyd" "grub")

echo "Stowing home dotfiles from $DOTFILES_DIR..."

fd -t d --max-depth 1 --exclude '.git' . "$DOTFILES_DIR" | sed 's|/$||' | while read -r dirpath; do
    dir=$(basename "$dirpath")

    # skip root-targeted dirs — handled separately
    skip=0
    for r in "${ROOT_DIRS[@]}"; do
        if [ "$dir" = "$r" ]; then
            skip=1
            break
        fi
    done
    [ "$skip" = 1 ] && continue

    echo "Stowing: $dir"
    if stow "$dir" 2>&1; then
        echo "  -> Success"
    else
        echo "  -> Failed (may already be stowed or conflicts exist)"
    fi
done

echo ""
echo "Stowing root dotfiles (requires sudo)..."

for dir in "${ROOT_DIRS[@]}"; do
    if [ ! -d "$DOTFILES_DIR/$dir" ]; then
        echo "Skipping $dir: not found"
        continue
    fi

    echo "Checking $dir for conflicts..."
    # simulate to detect existing files that would conflict
    if sudo stow -n -t / "$dir" 2>&1; then
        sudo stow -t / "$dir"
        echo "  -> Success"
    else
        echo "  -> Skipping $dir (target files already exist)"
    fi
done

echo "Done!"
