_fic() {
  emulate -L zsh

  local recursive="$1"
  local respect_ignored="$2"
  local suffix="${3#.}"

  if [[ -z "$suffix" ]]; then
    print -u2 "Usage: ${funcstack[2]} <extension-or-suffix>"
    return 1
  fi

  local -a args=(
    --type f
    --hidden
    --glob "*.${suffix}"
  )

  # Default variants include files excluded by .gitignore/.ignore.
  (( respect_ignored )) || args+=(--no-ignore)

  # Limit search to the current directory.
  (( recursive )) || args+=(--max-depth 1)

  fd "${args[@]}" . | wc -l | tr -d ' '
}

# Recursive, including ignored files
ficr() {
  _fic 1 0 "$1"
}

# Current directory only, including ignored files
fic() {
  _fic 0 0 "$1"
}

# Recursive, respecting ignore files
ficri() {
  _fic 1 1 "$1"
}

# Current directory only, respecting ignore files
fici() {
  _fic 0 1 "$1"
}
