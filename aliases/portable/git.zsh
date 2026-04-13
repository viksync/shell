g() {
  git "$@"
}

#------------------------
#       Status
# -----------------------

gss() {
  git status -s "$@"
}

gsl() {
  git status "$@"
}

#------------------------
#       Logs
# -----------------------

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


#------------------------
#       Switch
# -----------------------

gs() {
  git switch "$@"
}

gsc() {
  git switch -c "$@"
}

g-() {
  git switch -
}

#------------------------
#       Push/Pull
# -----------------------

gp() {
  git push "$@"
}

gpl() {
  git pull "$@"
}

gps () {
    git push && return 0

    local branch
    branch=$(git branch --show-current)

    if [[ -n "$branch" ]]; then
        echo "⚡ Setting upstream for $branch"
        git push --set-upstream origin "$branch"
    fi
}

#------------------------
#       Add
# -----------------------

ga() {
  git add "$@"
}

gaa() {
  git add -A "$@"
}

gar() {
  git add . "$@"
}

gau() {
  git add -u "$@"
}

gap() {
  git add -p "$@"
}


#------------------------
#       Stash
# -----------------------

gst() {
  git stash
}

gstp() {
  git stash pop
}

gstl() {
  git stash list
}

gstp() {
  git stash push -m "$@"
}

#------------------------
#       Commit
# -----------------------

gc() {
  git commit -m "$@"
}

# stages all modified ⚠ tracked files 
gcam() {
  git commit -a -m "$@"
}

gca() {
  git commit --ammend "$@"
}

gcan() {
  git commit -a --amend --no-edit "$@"
}


#------------------------
#       Merge
# -----------------------

gm() {
  git merge "$@"
}

gmf() {
  git merge --ff-only "$@"
}

gmnf() {
  git merge --no-ff "$@"
}

#------------------------
#       Reset
# -----------------------

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

#------------------------
#       Config
# -----------------------

gsc() {
  git config --list --show-origin "$@"
}

#------------------------
#       Worktrees
# -----------------------

gwa() {
  git worktree add "$@"
}

gwr() {
  git worktree remove "$@"
}

gwl() {
  git worktree list
}
