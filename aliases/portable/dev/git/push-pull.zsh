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
