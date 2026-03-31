source $HOME/.config/shell/aliases.base.zsh

_ALIASES="$HOME/.config/shell/aliases"

for f in "$_ALIASES"/*.mac.zsh; do source "$f"; done

unset _ALIASES
