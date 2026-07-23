gl() {
  git log "$@"
}

gll() {
  git log -1 "$@"
}

glo() {
  if [[ -z "$1" ]]; then
    git log --oneline -n 1
  elif [[ "$1" =~ ^[0-9]+$ ]]; then
    git log --oneline -n "$1" "${@:2}"
  else
    git log --oneline -n 1 "$@"
  fi
}

gloa() {
  git log --oneline "$@"
}

glon() {
  if [[ -z "$1" ]]; then
    git log --oneline --no-decorate -n 1
  elif [[ "$1" =~ ^[0-9]+$ ]]; then
    git log --oneline --no-decorate -n "$1" "${@:2}"
  else
    git log --oneline --no-decorate -n 1 "$@"
  fi
}

glom() {
  git log --all --author="$(git config user.name)" --since=midnight --oneline
}


