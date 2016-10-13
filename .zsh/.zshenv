# ignore /etc/z* (especially /etc/zprofile on Mac)
unsetopt GLOBAL_RCS

# Zsh DOTfile DIRectory
export ZDOTDIR=${HOME}/.zsh

# Shared with bash
if [ -f ~/.profile ]; then
    . ~/.profile
fi

export PYTHONPATH=${HOME}/local/lib/python:${PYTHONPATH}

# Permission
[[ ${UID} > 0 && ${UID} = ${GID} ]] && umask 002 || umask 022
