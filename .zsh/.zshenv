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
    if [ -d ${HOME}/.homebrew ]; then
        PATH=${HOME}/.homebrew/bin:${PATH}
        brew_prefix=$(brew --prefix)
        PATH=${brew_prefix}/opt/coreutils/libexec/gnubin:${PATH}
        PATH=${brew_prefix}/opt/gnu-sed/libexec/gnubin:${PATH}
        PATH=${brew_prefix}/opt/gnu-tar/libexec/gnubin:${PATH}
        PATH=${brew_prefix}/opt/qt5/bin:${PATH}
    fi
elif [ $(uname) = Linux ]; then
    source /etc/environment
fi

# Path
PATH=/opt/local/bin:/opt/local/sbin:${PATH}
PATH=${HOME}/local/bin:${HOME}/local/scripts:${PATH}
export PATH

export PYTHONPATH=${HOME}/local/lib/python:${PYTHONPATH}

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Permission
[[ ${UID} > 0 && ${UID} = ${GID} ]] && umask 002 || umask 022
