# Create worktree + branch
gwc () {
	local branch="$1"
	local base="${2:-$(git branch --show-current)}"

	if [[ -z "$branch" ]]; then
		echo "usage: gwc <branch-name> [base]"
		return 1
	fi

	local repo_root
	repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
		echo "not inside a git repo"
		return 1
	}

	local safe_name="${branch//\//-}"
	local parent_dir="${repo_root:h}"

	local worktrees_root
	if [[ "${parent_dir:t}" == "worktrees" ]]; then
		worktrees_root="$parent_dir"
	else
		worktrees_root="$repo_root/../worktrees"
	fi

	local worktree_dir="$worktrees_root/$safe_name"

	mkdir -p "$worktrees_root"

	if [[ -e "$worktree_dir" ]]; then
		echo "worktree dir already exists: $worktree_dir"
		return 1
	fi

	if git show-ref --verify --quiet "refs/heads/$branch"; then
		git worktree add "$worktree_dir" "$branch"
	else
		git worktree add -b "$branch" "$worktree_dir" "$base"
	fi
}

# Remove worktree by branch name
gwd () {
    local force=0
    if [[ "$1" == "-f" ]]; then force=1; shift; fi

    local branch="$1"
    if [[ -z "$branch" ]]; then
        echo "usage: gwd [-f] <branch-name>"
        return 1
    fi

    local git_dir git_common_dir repo_root worktree_dir safe_name

    git_dir="$(git rev-parse --git-dir 2>/dev/null)" || { echo "not inside a git repo"; return 1; }
    git_common_dir="$(git rev-parse --git-common-dir 2>/dev/null)"
    repo_root="$(git rev-parse --show-toplevel 2>/dev/null)"
    safe_name="${branch//\//-}"

    if [[ "$git_dir" == "$git_common_dir" ]]; then
        # We're in the main worktree — siblings live in ../worktrees/
        worktree_dir="$(realpath "$repo_root/../worktrees/$safe_name")"
    else
        # We're inside a worktree — siblings are at ../
        worktree_dir="$(realpath "$repo_root/../$safe_name")"
    fi

    local remove_it() {
        git worktree remove ${1:+--force} "$worktree_dir"
    }

    if (( force )); then
        git worktree remove --force "$worktree_dir"
        return
    fi

    if git worktree remove "$worktree_dir" 2>/dev/null; then
        return
    fi

    read -q "reply?Worktree contains modified or untracked files. Force remove? [y/N] "
    echo
    if [[ "$reply" =~ ^[Yy]$ ]]; then
        git worktree remove --force "$worktree_dir"
    else
        echo "aborted"
        return 1
    fi
}

gwdb () {
    local branch="$1"
    
    gwd "$@" && git branch --delete --force "$branch"
}

gwcd () {
	local branch="$1"

	if [[ -z "$branch" ]]; then
		echo "usage: gwcd <branch-name>"
		return 1
	fi

	local repo_root
	repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
		echo "not inside a git repo"
		return 1
	}

	local parent_dir="${repo_root:h}"
	local worktrees_root

	if [[ "${parent_dir:t}" == "worktrees" ]]; then
		worktrees_root="$parent_dir"
	else
		worktrees_root="$repo_root/../worktrees"
	fi

	local safe_name="${branch//\//-}"
	local target="$worktrees_root/$safe_name"

	if [[ ! -d "$target" ]]; then
		echo "worktree does not exist: $target"
		return 1
	fi

	cd "$target"
}

gwa() {
  git worktree add "$@"
}

gwr() {
  git worktree remove "$@"
}

gwl() {
  git worktree list
}

gwp() {
  git worktree prune
}

