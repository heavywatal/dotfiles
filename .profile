#!/bin/sh
case "$(uname)" in
  Darwin)
    export COPYFILE_DISABLE=true
    export SHELL_SESSIONS_DISABLE=1
    export BASH_SILENCE_DEPRECATION_WARNING=1
    if [ -x /usr/libexec/path_helper ]; then
        PATH=''
        eval $(/usr/libexec/path_helper -s)
    fi
    ;;
  Linux)
    PATH=/usr/bin:/bin
    [ -f /etc/environment ] && . /etc/environment
    [ -f /etc/profile ] && . /etc/profile
    ;;
esac

# PATH
if [ -z "$HOMEBREW_PREFIX" ]; then
  for prefix in /usr/local /opt/homebrew /home/linuxbrew/.linuxbrew ~/.homebrew; do
    if [ -e ${prefix}/bin/brew ]; then
      PATH=${PATH#${prefix}/bin:}
      eval $(${prefix}/bin/brew shellenv)
    fi
  done
fi

PERL5LIBLOCAL="${HOME}/local/lib/perl5"
export PERL_CPANM_OPT="--local-lib=${PERL5LIBLOCAL}"
export PERL5LIB="${PERL5LIBLOCAL}/lib/perl5"

export WORKON_HOME="${HOME}/.virtualenvs"
# /usr/bin/python3 -m venv ${WORKON_HOME}/reticulate

export PYENV_ROOT=${HOME}/.pyenv
if [ -d $PYENV_ROOT ]; then
    pyenv_versions=($(ls ${PYENV_ROOT}/versions | sort -V))
    export PYENV_LATEST=${PYENV_ROOT}/versions/${pyenv_versions[@]: -1}
    PATH=${PYENV_LATEST}/bin:$PATH
    unset pyenv_versions
fi
PATH=$(python3 -m site --user-base)/bin:$PATH

export GOPATH=${HOME}/.go
PATH=${GOPATH}/bin:$PATH

PATH=${HOME}/.cargo/bin:$PATH

PATH=${UCSC_KENT_BIN:=${HOME}/.ucsc-kent/bin}:$PATH
export UCSC_KENT_BIN

PATH=${HOME}/local/bin:${HOME}/.config/bin:$PATH
export PATH
export MANPATH

# Language
export LANG=C
export LC_CTYPE=en_US.UTF-8
