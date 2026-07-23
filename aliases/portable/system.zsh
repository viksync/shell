# split path by : and join with \n
ep() {
  echo $PATH | tr ':' '\n'
}

w() { which "$@" }

# ===============================
# processes
# ===============================

psp() {
  ps -p $1 -o pid,ppid,user,command
}

