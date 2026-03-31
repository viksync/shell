# Homebrew completions — sourced before compinit in zshrc.base
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
  fpath=($(brew --prefix)/share/zsh-completions $fpath)
fi
