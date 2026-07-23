# fuzzy + bat preview
fzp() {
  fzf --preview="bat --color=always {}" "$@"
}

# fuzzy + open in vim
fzv() {
  nvim $(fzf -m --preview="bat --color=always {}") "$@"
}

