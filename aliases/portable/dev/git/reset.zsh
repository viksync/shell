gr() {
  git reset "$@"
}

grs() {
  local target="HEAD"
  [[ -n "$1" ]] && target="HEAD~$1"
  git reset --soft "$target"
}

grh() {
  local target="HEAD"
  [[ -n "$1" ]] && target="HEAD~$1"
  git reset --hard "$target"
}

