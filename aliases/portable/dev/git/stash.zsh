gst() {
  git stash -u
}

gstp() {
  git stash pop
}

gstl() {
  git stash list
}

gstm() {
  git stash push -m "$@"
}
