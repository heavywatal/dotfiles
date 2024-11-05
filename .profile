#!/bin/sh
case "$(uname)" in
  Darwin)
    export COPYFILE_DISABLE=true
    export SHELL_SESSIONS_DISABLE=1
    export BASH_SILENCE_DEPRECATION_WARNING=1
    if [ -x /usr/libexec/path_helper ]; then
        export PATH=''
        export MANPATH=''
        eval "$(/usr/libexec/path_helper -s)"
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
      HOMEBREW_PREFIX=$prefix
      break
    fi
  done
  unset prefix
fi
if [ -n "$HOMEBREW_PREFIX" ] && [ -z "$HOMEBREW_NO" ]; then
  export HOMEBREW_NO_AUTO_UPDATE=1
  PATH=${PATH#"${HOMEBREW_PREFIX}"/bin:}
  eval "$("${HOMEBREW_PREFIX}"/bin/brew shellenv)"
fi

PERL5LIBLOCAL="${HOME}/local/lib/perl5"
export PERL_CPANM_OPT="--local-lib=${PERL5LIBLOCAL}"
export PERL5LIB="${PERL5LIBLOCAL}/lib/perl5"

export WORKON_HOME="${HOME}/.virtualenvs"
export UV_PYTHON=3.12
export UV_PYTHON_PREFERENCE=only-managed
if [ -d "${VIRTUAL_ENV:=${WORKON_HOME}/${UV_PYTHON}}" ]; then
  export VIRTUAL_ENV
  PATH=${VIRTUAL_ENV}/bin:$PATH
fi

export GOPATH="${HOME}/.go"
PATH=${GOPATH}/bin:$PATH

PATH=${HOME}/.cargo/bin:$PATH

PATH=${UCSC_KENT_BIN:=${HOME}/.ucsc-kent/bin}:$PATH
export UCSC_KENT_BIN

PATH=${HOME}/local/bin:${HOME}/.config/bin:$PATH

# Language
export LANG=C
export LC_CTYPE=en_US.UTF-8
