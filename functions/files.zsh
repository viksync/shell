# touch executale + vim
te() {
  local file="$1"
  if [[ -z "$file" ]]; then
    echo "Usage: te <filename>"
    return 1
  fi
  touch "$file" && chmod +x "$file" && nvim "$file"
}

# prepend to file
# usage: pre "text" filename
pre() {
  local text=$1
  local file=$2

  [[ -z $text || -z $file ]] && { echo "Usage: pre \"text\" filename"; return 1 }
  [[ ! -f $file ]] && { echo "File not found: $file"; return 1 }

  # Prepend text and overwrite file atomically
  { echo "$text"; cat "$file"; } > "${file}.tmp" && mv "${file}.tmp" "$file"
}
