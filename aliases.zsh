source $HOME/.config/shell/aliases.base.zsh

_ALIASES="$HOME/.config/shell/aliases"

for _f in "$_ALIASES"/mac/*.zsh; do source "$_f"; done
unset _f

unset _ALIASES
