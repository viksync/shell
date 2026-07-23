# sudo
_() { sudo "$@" }

# repeat previous with sudo
f() { sudo "$(fc -ln -1)"; }

# repeat previous command
j() { fc -s }

clr() { clear }

