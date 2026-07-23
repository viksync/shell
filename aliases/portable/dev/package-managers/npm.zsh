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
