lns() {
  ln -s "$@"
}

# ln -s for all arguments separately
lnsm() {
    for f in "$@"; do
        local base="${f##*/}"   # strip path, keep filename
        ln -s "$f" "$base"
    done
}
