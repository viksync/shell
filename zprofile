# ----------------------------------------
# PATH Configuration
# This is the single source of truth for PATH ordering
# Runs once at login before .zshrc
# ----------------------------------------

# Start with a clean slate
path=()

# Homebrew paths FIRST (highest priority)
path+=(
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
)

# User scripts
path+=(
    "$HOME/.config/shell/scripts"
)

# Local tools
path+=(
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.lmstudio/bin"
    "$HOME/.antigravity/antigravity/bin"
    "$HOME/.opencode/bin"
    "/Applications/Obsidian.app/Contents/MacOS"
)

# Bun
export BUN_INSTALL="$HOME/.bun"
path+=("$BUN_INSTALL/bin")

# System paths (lowest priority, as fallback)
path+=(
    /usr/local/bin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
)

# Deduplicate and export
typeset -U path
export PATH
