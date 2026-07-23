g() {
  git "$@"
}

# Remove all merge-conflict files in DU state (keep deletion)
grdu() {
    git status --porcelain -z |
    perl -0ne 'print "$1\0" while /^DU (.*?)\0/gm' |
    xargs -0 git rm --
}

# init + commit
gci() {
  git init && git add -A && git commit -m 'init'
}
