# ===============================
# SYSTEM & SHELL
# ===============================

# Source & reload configs

# so → source + command
soz() {
  source $HOME/.zshrc "$@"
}

soa() {
  source $HOME/.config/shell/aliases.zsh "$@"
}

# e → edit + command
ea() {
  nvim $HOME/.config/shell/aliases.zsh && source $HOME/.config/shell/aliases.zsh
}

ez() {
  nvim $HOME/.zshrc && source $HOME/.zshrc
}

es() {
  v $HOME/.config/shell/scripts/ "$@"
}

# Config inspection
bz() {
  bat $HOME/.zshrc "$@"
}

ba() {
  bat $HOME/.config/shell/aliases.zsh "$@"
}

# split path by : and join with \n
ep() {
  echo $PATH | tr ':' '\n'
}

w() {
  which "$@"
}

# Sudo
_() {
  sudo "$@"
}

# Repeat previous with sudo
f() { sudo "$(fc -ln -1)"; }

# Repeat previous command
j() { fc -s }

cl() { clear }

# ===============================
# FILES
# ===============================
# fi → file + command

# file size 
fis() {
  du -sh "$@"
}

# show number of files in current dir
fin() {
    local dir="${1:-.}"
    ls -A "$dir" 2>/dev/null | wc -l | xargs
}

# copy file contents
fic() {
  pbcopy < "$@"
}

# copy clipboard contents to a file
fip() {
  pbpaste > "$@"
}

# copy file path
fipa() {
  local abs_path
  abs_path=$(realpath "$1" 2>/dev/null) || return
  printf "%s\n" "$abs_path" | tee >(pbcopy)
}

# Hide file
fih() {
  chflags hidden "$@"
}

# Unhide file
fiu() {
  chflags nohidden "$@"
}

# ===============================
# Fuzzy
# ===============================

# fuzzy + bat preview
fzp() {
  fzf --preview="bat --color=always {}" "$@"
}

# fuzzy + open in vim
fzv() {
  nvim $(fzf -m --preview="bat --color=always {}") "$@"
}

# ===============================
# Execution
# ===============================

# execute with arguments
function x() {
  local file="$1"
  shift  # remove the first argument so "$@" contains the rest

  # Check if file exists and is executable
  if [[ -f "$file" && -x "$file" ]]; then
    # Run it with any additional arguments
    "./$file" "$@"
  elif [[ -f "$file" ]]; then
    echo "File exists but is not executable: $file" >&2
    return 1
  else
    echo "File not found: $file" >&2
    return 1
  fi
}

# Make executable
mx() {
  chmod +x "$@"
}

# make executable and execute with arguments
function mxx() {
  local file="$1"
  shift  # remaining args for the script

  if [[ -f "$file" ]]; then
    chmod +x "$file"  # make it executable
    x "$file" "$@"    # call your existing x function with all remaining args
  else
    echo "File not found: $file"
    return 1
  fi
}


# ===============================
# ls → eza
# ===============================

# wihout -l it does nothing, with -l shows folder size
# e() {
#   eza --total-size "$@"
# }

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


# ===============================
# Symlinks
# ===============================

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


# ===============================
# Preview
# ===============================

b() {
  bat "$@"
}

bw() {
  local width="${1:-80}"
  bat --terminal-width="$width" "${@:2}"
}


# ===============================
# Navigation
# ===============================

# copy working dir
cwd() {
  pwd | pbcopy
}

# Directory shortcuts
function ..() { cd .. }
function ...() { cd ../.. }
function ....() { cd ../../.. }
function .....() { cd ../../../.. }
function cd-() { cd - > /dev/null }
function ~() { cd $HOME }

# Quick navigation
zdw() {
  z $HOME/Downloads/ "$@"
}

zde() {
  z $HOME/Desktop/ "$@"
}

zp() {
  z $HOME/Projects/ "$@"
}

# ===============================
# Directories
# ===============================

md() {
  s mkdir -p "$@"
}

# create dir and cd to it
function mdc() {
  mkdir -p "$1" && cd "$1"
}

rmd() {
  s rm -r "$@"
}

rmf() {
  s rm -rf "$@"
}

# ===============================
# DEVELOPMENT TOOLS
# ===============================

# ==========
# EDITORS
# ==========

v() {
  nvim "$@"
}

vc() {
  nvim $HOME/.config/nvim/ "$@"
}

vk() {
  nvim $HOME/.config/nvim/lua/config/keymaps.lua "$@"
}

vs() {
  code . "$@"
}

# ==========
# NODE.JS
# ==========

n() {
  node "$@"
}

nv() {
  node --version "$@"
}

# ==========
# PYTHON
# ==========

python() {
  python3 "$@"
}

pip() {
  pip3 "$@"
}

# ==========
# GIT
# ==========

g() {
  git "$@"
}

gs() {
  git status -s "$@"
}

gsl() {
  git status "$@"
}

gl() {
  git log "$@"
}

gll() {
  git log -1 "$@"
}

glo() {
  git log --oneline "$@"
}

gp() {
  git push "$@"
}

ga() {
  git add "$@"
}

gam() {
  git commit -a -m "$@"
}

gaa() {
  git add * "$@"
}

gar() {
  git add . "$@"
}

gu() {
  git add -u "$@"
}

gsc() {
  git config --list --show-origin "$@"
}

gan() {
  git commit -a --amend --no-edit "$@"
}

# Dotfiles management
# dots() {
#   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME "$@"
# }


# ==========
# ZELLIJ
# ==========

ze() {
  zellij "$@"
}

# ===============================
# PACKAGE MANAGERS
# ===============================

# Homebrew
# ==========

bi() {
  sb brew install "$@"
}

bic() {
  sb brew install --cask "$@"
}

bu() {
  sb brew uninstall "$@"
}

bs() {
  brew search "$@"
}

bif() {
  brew info "$@"
}

bl() {
  brew leaves "$@"
}

# brew install silent
bis() {
  if [ $# -eq 0 ]; then
    echo "Usage: bis <formula1> [formula2 ...]"
    return 1
  fi
  for pkg in "$@"; do
    if brew install "$pkg" >/dev/null 2>&1; then
      echo "🍺 Installed $pkg"
    else
      echo "Failed to install $pkg"
    fi
  done
}

bc() {
  brew cleanup "$@" &!
}

buu() {
  sb brew update && brew upgrade
}

bup() {
  sb brew update "$@"
}

bug() {
  sb brew upgrade "$@"
}

bo() {
  brew outdated "$@"
}

bsl() {
  brew services list "$@"
}


# npm
# ==========

nlg() {
  npm list -g "$@"
}

nig() {
  s npm install -g "$@"
}

nu() {
  s npm install -g npm@latest "$@"
}

nug() {
  s npm update -g "$@"
}

npv() {
  npm -v "$@"
}

# like brew leaves
nl() {
  npm ls -g --depth=0 --parseable | tail -n +2 | xargs -n 1 basename
}

nd() {
  npm run dev "$@"
}

pn() {
  pnpm "$@"
}


# ===============================
# tools
# ===============================


# yazi
# ==========

# open without changing current dir
y() {
  yazi "$@"
}

# change the dir to chosen in yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# edit espanso
ee() {
  (cd ~/Library/Application\ Support/espanso/match/; nvim)
}

yd() {
  yt-dlp "$@"
}


# ===============================
# ai
# ===============================

ai() {
  ollama run Modelfile --nowordwrap "$1" | zsh
}

c() {
  claude "$@"
}

cr() {
  claude --resume
}

cn() {
    local lock_file
    lock_file=$(ls -t ~/.claude/ide/*.lock 2>/dev/null | head -1)

    if [[ -z "$lock_file" ]]; then
      echo "No claudecode.nvim server found. Is Neovim open?" >&2
      return 1
    fi

    local port
    port=$(basename "$lock_file" .lock)

    echo "Connecting to Neovim on port $port..."
    CLAUDE_CODE_SSE_PORT="$port" ENABLE_IDE_INTEGRATION=true claude "$@"
  }

# ===============================
# webdev
# ===============================

cul() {
  curl localhost:3000$1
}

hl() {
  http localhost:3000$1
}

# ===============================
# processes
# ===============================

psp() {
  ps -p $1 -o pid,ppid,user,command
}

# ===============================
# networking
# ===============================

# WOL
wol() {
  BCAST="10.0.255.255"
  MAC="${1:-$PC_MAC}"

  printf 'FFFFFFFFFFFF%s' "$(printf '%s' ${MAC}%.0s {1..16})" \
    | xxd -r -p \
    | nc -u "$BCAST" 9
}

ip() {
  ifconfig | grep 'broadcast 10.0.255.255' | awk '{print $2}'
}

# ===============================
# linux
# ===============================

tiny() {
  qemu-system-x86_64 -cdrom ~/Linux/iso/Core-current.iso -m 512 -netdev user,id=net0,hostfwd=tcp::2222-:22 -device e1000,netdev=net0 "$@"
}


# ===============================
# PornHub
# ===============================
dph() (
  cd "$HOME/Movies/ph" || return 1
  s yt-dlp "$@"
)



lap() {
  find /Applications -maxdepth 1 -type d -name "*.app" ! -name ".*" -exec basename "{}" .app \;
}

alias dp="noglob dph"
