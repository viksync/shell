# ----------------------------------------
# Powerlevel10k instant prompt
# ----------------------------------------

# Code that requires input (password prompts, [y/n])
# must go above this block.
# Everything else below.
local p10instant="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

if [[ -r $p10instant ]]; then
  source $p10instant
fi


source $HOME/.config/shell/zshrc.base

# ----------------------------------------
# Dev tools (macOS)
# ----------------------------------------

. "$HOME/.vite-plus/env"

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME/bin:$PATH"

# Pi
export PATH="/Users/vic/.vite-plus/js_runtime/node/24.16.0/bin:$PATH"
