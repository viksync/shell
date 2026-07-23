gm() {
  git merge "$@"
}

gmf() {
  git merge --ff-only "$@"
}

gmnf() {
  git merge --no-ff "$@"
}
