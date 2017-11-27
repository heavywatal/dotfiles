# Ignore /etc/z* (especially /etc/zprofile on Mac)
unsetopt GLOBAL_RCS

# Leave unmatched patterns unchanged
unsetopt NOMATCH

# Shared with bash
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# Permission
[[ ${UID} > 0 && ${UID} = ${GID} ]] && umask 002 || umask 022