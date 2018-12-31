#!/bin/sh
if [ $(uname) = Darwin ]; then
    export MACOSX_DEPLOYMENT_TARGET=$(sw_vers -productVersion | cut -d. -f-2)
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
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
    PATH=${brew_prefix}/opt/gnu-sed/libexec/gnubin:${brew_prefix}/opt/gnu-tar/libexec/gnubin:${brew_prefix}/opt/coreutils/libexec/gnubin:$PATH
    MANPATH=${brew_prefix}/opt/gnu-sed/libexec/gnuman:${brew_prefix}/opt/gnu-tar/libexec/gnuman:${brew_prefix}/opt/coreutils/libexec/gnuman:$MANPATH
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUTO_UPDATE=1
fi
unset brew_prefix

PATH=${HOME}/.nodebrew/current/bin:$PATH

export GOPATH=${HOME}/.go
PATH=${GOPATH}/bin:$PATH

export PYENV_ROOT=${HOME}/.pyenv
if [ -d $PYENV_ROOT ]; then
    PATH=${PYENV_ROOT}/bin:$PATH
    PATH=${PYENV_ROOT}/versions/$(pyenv global)/bin:$PATH
fi
PATH=$(python -m site --user-base)/bin:$PATH
PATH=${HOME}/local/bin:${HOME}/.config/bin:$PATH
export PATH
export MANPATH

# Language
export LANG=C
export LC_CTYPE=en_US.UTF-8
