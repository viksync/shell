gsc() {
  git config --list --show-origin "$@"
}

gue() {
  git config --show-origin user.email
}

gun() {
  git config --show-origin user.name
}
