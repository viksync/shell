# ===============================
# Clipboard
# ===============================

# copy file contents
fic() {
  pbcopy < "$@"
}

# copy clipboard contents to a file
fip() {
  pbpaste > "$@"
}

# copy file path
fipa() {
  local abs_path
  abs_path=$(realpath "$1" 2>/dev/null) || return
  printf "%s\n" "$abs_path" | tee >(pbcopy)
}

# copy working dir
cwd() {
  pwd | pbcopy
}
