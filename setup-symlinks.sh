#!/usr/bin/env bash
# Sets up symlinks for shell configuration files.
# Safe to re-run: skips existing correct symlinks, warns on conflicts.

set -euo pipefail

SHELL_DIR="$HOME/.config/shell"

link() {
  local target="$1"
  local link="$2"

  if [[ -L "$link" ]]; then
    if [[ "$(readlink "$link")" == "$target" ]]; then
      echo "  ok  $link"
      return
    else
      echo "  !! $link exists but points to $(readlink "$link") — skipping"
      return
    fi
  fi

  if [[ -e "$link" ]]; then
    echo "  !! $link exists as a regular file — skipping (back it up first)"
    return
  fi

  ln -s "$target" "$link"
  echo " new  $link -> $target"
}

echo "Setting up shell symlinks..."

# Zsh
link "$SHELL_DIR/zshrc" "$HOME/.zshrc"
link "$SHELL_DIR/zshenv" "$HOME/.zshenv"
link "$SHELL_DIR/zprofile" "$HOME/.zprofile"

echo "Done."
