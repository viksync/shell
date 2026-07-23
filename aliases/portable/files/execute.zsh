# execute with arguments
function x() {
  local file="$1"
  shift  # remove the first argument so "$@" contains the rest

  # Check if file exists and is executable
  if [[ -f "$file" && -x "$file" ]]; then
    # Run it with any additional arguments
    "./$file" "$@"
  elif [[ -f "$file" ]]; then
    echo "File exists but is not executable: $file" >&2
    return 1
  else
    echo "File not found: $file" >&2
    return 1
  fi
}

# make executable
mx() {
  s chmod +x "$@"
}

# make executable and execute with arguments
function mxx() {
  local file="$1"
  shift  # remaining args for the script

  if [[ -f "$file" ]]; then
    chmod +x "$file"  # make it executable
    x "$file" "$@"    # call your existing x function with all remaining args
  else
    echo "File not found: $file"
    return 1
  fi
}

# touch executable + vim
te() {
  local file="$1"
  if [[ -z "$file" ]]; then
    echo "Usage: te <filename>"
    return 1
  fi
  touch "$file" && chmod +x "$file" && nvim "$file"
}

