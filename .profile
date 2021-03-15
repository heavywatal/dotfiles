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
for prefix in /usr/local /opt/homebrew ~/.linuxbrew ~/.homebrew; do
    [ -e ${prefix}/bin/brew ] && eval $(${prefix}/bin/brew shellenv)
done
if [ -n "$HOMEBREW_PREFIX" ]; then
    for formula in gnu-sed gnu-tar grep; do
        GNUBIN=${HOMEBREW_PREFIX}/opt/${formula}/libexec/gnubin
        [ -d "$GNUBIN" ] && PATH=$GNUBIN:$PATH
    done
    unset GNUBIN
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_INSTALL_CLEANUP=1
fi

PATH=${HOME}/.nodebrew/current/bin:$PATH

PATH=${HOME}/.cargo/bin:$PATH

export GOPATH=${HOME}/.go
PATH=${GOPATH}/bin:$PATH

if [ -n "$NVM_DIR" ]; then
    export NVM_DIR
    . "$NVM_DIR/nvm.sh"
    . "$NVM_DIR/bash_completion"
fi

PERL5LIBLOCAL="${HOME}/local/lib/perl5"
export PERL_CPANM_OPT="--local-lib=${PERL5LIBLOCAL}"
export PERL5LIB="${PERL5LIBLOCAL}/lib/perl5"

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
