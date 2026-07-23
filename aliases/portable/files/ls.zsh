# ls → eza

ls() {
  eza "$@"
}

# tree with node_modules ignored by default when level >= 2
lt() {
    local level=1

    # if first argument is a number, treat it as level
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        level="$1"
        shift  # only safe to shift here
    fi

    # build command
    local cmd=(eza --tree --level="$level")
    if (( level >= 2 )); then
        cmd+=(-I node_modules)
    fi
    cmd+=("$@")  # add any extra flags

    "${cmd[@]}"
}

# show only dot items
lsd() {
  eza -d .* -f "$@"
}
