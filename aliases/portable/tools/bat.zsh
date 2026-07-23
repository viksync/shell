b() {
  bat "$@"
}

bw() {
  local width="${1:-80}"
  bat --terminal-width="$width" "${@:2}"
}
