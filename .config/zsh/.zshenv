# Ignore /etc/z* (especially /etc/zprofile on Mac)
unsetopt GLOBAL_RCS

# Leave unmatched patterns unchanged
unsetopt NOMATCH

# Shared with bash
[ -z "$TMUX" -a -f ~/.profile ] && . ~/.profile
