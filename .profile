#!/bin/sh
if [ $(uname) = Darwin ]; then
    # Resource Fork reduction for 'tar'
    export COPYFILE_DISABLE=true
    if [ -x /usr/libexec/path_helper ]; then
        PATH=''
        MANPATH=''
        eval $(/usr/libexec/path_helper -s)
    fi
elif [ $(uname) = Linux ]; then
    PATH=/usr/bin:/bin
    . /etc/environment
    . /etc/profile
fi

# PATH
for prefix in /usr/local /opt/local ~/.linuxbrew ~/.homebrew; do
    if [ -d $prefix ]; then
        PATH=${prefix}/bin:${prefix}/sbin:$PATH
        MANPATH=${prefix}/share/man:$MANPATH
    fi
done
brew_prefix=$(brew --prefix 2>/dev/null)
if [ -n "${brew_prefix}" ]; then
    for formula in coreutils findutils gnu-sed gnu-tar grep; do
        PATH=${brew_prefix}/opt/${formula}/libexec/gnubin:$PATH
        MANPATH=${brew_prefix}/opt/${formula}/libexec/gnuman:$MANPATH
    done
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_INSTALL_CLEANUP=1
fi
unset brew_prefix

PATH=${HOME}/.nodebrew/current/bin:$PATH

export GOPATH=${HOME}/.go
PATH=${GOPATH}/bin:$PATH

if [ -n "$NVM_DIR" ]; then
    export NVM_DIR
    . "$NVM_DIR/nvm.sh"
    . "$NVM_DIR/bash_completion"
fi

export PYENV_ROOT=${HOME}/.pyenv
if [ -d $PYENV_ROOT ]; then
    PATH=${PYENV_ROOT}/bin:$PATH
    pyenv_versions=(${PYENV_ROOT}/versions/*)
    PATH=${pyenv_versions[@]: -1}/bin:$PATH
    unset pyenv_versions
fi
PATH=$(python3 -m site --user-base)/bin:$PATH
PATH=${HOME}/local/bin:${HOME}/.config/bin:$PATH
export PATH
export MANPATH

# Language
export LANG=C
export LC_CTYPE=en_US.UTF-8
