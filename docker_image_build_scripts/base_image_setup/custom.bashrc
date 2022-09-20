#
#

#export PS1="\[\033[35m\]<Docker Development Environment>\[\033[m\] \[\033[36m\] text \[\033[m\]@\[\033[32m\] host :\[\033[33;1m\]\w\[\033[m\]\$ "
export PS1="\[\033[36m\]<Docker Development Environment> :\[\033[33;1m\]\w\[\033[m\]\$ "

alias ll='ls -lart'

# When doing pip commands, it requires a writeable directory for the cache.
export PIP_CACHE_DIR=/tmp/cache