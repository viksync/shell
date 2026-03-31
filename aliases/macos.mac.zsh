# ===============================
# File flags
# ===============================

# Hide file
fih() {
  chflags hidden "$@"
}

# Unhide file
fiu() {
  chflags nohidden "$@"
}


# ===============================
# Editors
# ===============================

vs() {
  code . "$@"
}

esm() {
  v $HOME/.config/shell/mac-scripts/ "$@"
}


# ===============================
# Tools
# ===============================

ai() {
  ollama run Modelfile --nowordwrap "$1" | zsh
}

yd() {
  yt-dlp "$@"
}

# edit espanso
ee() {
  (cd ~/Library/Application\ Support/espanso/match/; nvim)
}

tiny() {
  qemu-system-x86_64 -cdrom ~/Linux/iso/Core-current.iso -m 512 -netdev user,id=net0,hostfwd=tcp::2222-:22 -device e1000,netdev=net0 "$@"
}

# list installed apps
lap() {
  find /Applications -maxdepth 1 -type d -name "*.app" ! -name ".*" -exec basename "{}" .app \;
}


# ===============================
# Networking (macOS)
# ===============================

# WOL
wol() {
  BCAST="10.0.255.255"
  MAC="${1:-$PC_MAC}"

  printf 'FFFFFFFFFFFF%s' "$(printf '%s' ${MAC}%.0s {1..16})" \
    | xxd -r -p \
    | nc -u "$BCAST" 9
}

ip() {
  ifconfig | grep 'broadcast 10.0.255.255' | awk '{print $2}'
}


# ===============================
# PH
# ===============================

dph() (
  cd "$HOME/Movies/ph" || return 1
  s yt-dlp "$@"
)

alias dp="noglob dph"
