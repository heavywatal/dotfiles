# privent compinit from being called in /etc/zsh/zshrc
skip_global_compinit=1

# Zsh DOTfile DIRectory
export ZDOTDIR=${HOME}/.zsh

if [ $(uname) = Darwin ]; then
    # Resource Fork reduction for 'tar'
    export COPYFILE_DISABLE=true
    export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
    if [ -x /usr/libexec/path_helper ]; then
        PATH=''
        eval $(/usr/libexec/path_helper -s)
    fi
elif [ $(uname) = Linux ]; then
    source /etc/environment
fi

if [ -f ${HOME}/.profile ]; then
    source ${HOME}/.profile
fi

export PYTHONPATH=${HOME}/local/lib/python:${PYTHONPATH}

# Permission
[[ ${UID} > 0 && ${UID} = ${GID} ]] && umask 002 || umask 022
