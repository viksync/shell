# ===============================
# Homebrew
# ===============================

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
