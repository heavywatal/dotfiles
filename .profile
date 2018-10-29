#!/bin/sh
if [ $(uname) = Darwin ]; then
    export MACOSX_DEPLOYMENT_TARGET=$(sw_vers -productVersion | cut -d. -f-2)
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    # Resource Fork reduction for 'tar'
    export COPYFILE_DISABLE=true
    export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
    if [ -x /usr/libexec/path_helper ]; then
        PATH=''
        eval $(/usr/libexec/path_helper -s)
    fi
elif [ $(uname) = Linux ]; then
    PATH=/usr/bin:/bin
    . /etc/environment
    . /etc/profile
fi

# PATH
PATH=/usr/local/sbin:$PATH
PATH=${PATH//:\/usr\/local\/sbin/}
PATH=/usr/local/bin:$PATH
PATH=${PATH//:\/usr\/local\/bin/}
MANPATH=/usr/local/man:/usr/local/share/man:
if [ -d /opt/local ]; then
    PATH=/opt/local/bin:/opt/local/sbin:$PATH
    MANPATH=/opt/local/man:/opt/local/share/man:${MANPATH}
fi
[ -d ~/.linuxbrew ] && PATH=${HOME}/.linuxbrew/bin:${HOME}/.linuxbrew/sbin:$PATH
[ -d ~/.homebrew ] && PATH=${HOME}/.homebrew/bin:${HOME}/.homebrew/sbin:$PATH
brew_prefix=$(brew --prefix 2>/dev/null)
if [ -n "${brew_prefix}" ]; then
    PATH=${brew_prefix}/opt/coreutils/libexec/gnubin:$PATH
    PATH=${brew_prefix}/opt/gnu-sed/libexec/gnubin:$PATH
    PATH=${brew_prefix}/opt/gnu-tar/libexec/gnubin:$PATH
    PATH=${brew_prefix}/opt/qt5/bin:$PATH
    MANPATH=${brew_prefix}/share/man:${MANPATH}
    MANPATH=${brew_prefix}/opt/coreutils/libexec/gnuman:${MANPATH}
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUTO_UPDATE=1
fi
unset brew_prefix

PATH=${HOME}/.nodebrew/current/bin:${PATH}

export GOPATH=${HOME}/.go
PATH=${GOPATH}/bin:${PATH}

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
