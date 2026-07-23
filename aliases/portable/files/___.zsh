# fi → file + command

# file size
fis() {
  du -sh "$@"
}

# change date
chd() {
  if [[ $# -lt 4 ]]; then
    echo "Usage: chd DD MM YY|YYYY file..."
    return 1
  fi

  local dd mm yyyy
  dd=$(printf "%02d" $1)
  mm=$(printf "%02d" $2)

  # Handle year
  if [[ ${#3} -eq 2 ]]; then
    yyyy="20$3"
  elif [[ ${#3} -eq 4 ]]; then
    yyyy="$3"
  else
    echo "Invalid year: $3 (use YY or YYYY)"
    return 1
  fi

  shift 3

  # Basic validation
  if (( mm < 1 || mm > 12 )); then
    echo "Invalid month: $mm"
    return 1
  fi

  if (( dd < 1 || dd > 31 )); then
    echo "Invalid day: $dd"
    return 1
  fi

  local ts="${yyyy}${mm}${dd}0000"

  for f in "$@"; do
    touch -t "$ts" "$f" || echo "Failed: $f"
  done
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
