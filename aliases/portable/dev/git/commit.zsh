gc() {
  git commit -m "$@"
}

# ------------
#  Add
# ------------

gca() {
  git add -A &&
  git commit -m "$*"
}

# all modified (⚠ only tracked files)
gcam() {
  git commit -a -m "$@"
}

# ------------
#  Amend
# ------------

gcame() {
  git commit --amend "$@"
}

gcamen() {
  git commit --amend --no-edit "$@"
}

gcamena() {
  git commit -a --amend --no-edit "$@"
}

# ------------
#  Semantic
# ------------

# Internal helper
_gco_commit() {
  local type="$1"
  shift

  local -a flags

  # Collect git commit flags (e.g. --no-verify, --amend, -S)
  while [[ "$1" == -* ]]; do
    flags+=("$1")
    shift
  done

  local scope="$1"
  shift

  local message="$*"

  if [[ -z "$scope" || -z "$message" ]]; then
    echo "Usage: ${FUNCNAME[2]} [git-commit-flags...] <scope> <message>"
    return 1
  fi

  git commit "${flags[@]}" -m "${type}(${scope}): ${message}"
}

gcof()  { _gco_commit feat "$@"; }
gcofi() { _gco_commit fix "$@"; }
gcoc()  { _gco_commit chore "$@"; }
gcor()  { _gco_commit refactor "$@"; }


# No-verify

gcofn()  { _gco_commit -n feat "$@"; }
gcofin() { _gco_commit -n fix "$@"; }
gcoch()  { _gco_commit -n chore "$@"; }
gcorn()  { _gco_commit -n refactor "$@"; }
