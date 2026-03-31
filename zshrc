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

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 2>/dev/null
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 2>/dev/null
