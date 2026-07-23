gcp() {
  git cherry-pick "$@"
}

gcpc() {
  git cherry-pick --continue
}

gcpa() {
  git cherry-pick --abort
}

