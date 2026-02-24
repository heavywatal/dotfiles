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
    PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    export BAT_THEME_FZF=auto:system
    ;;
  Linux)
    if [ -z "${BASH-}" ]; then
      PATH=/usr/bin:/bin
      [ -f /etc/environment ] && . /etc/environment
      [ -f /etc/profile ] && . /etc/profile
    fi
    ;;
esac

if [ -z "${HOMEBREW_PREFIX-}" ]; then
  for prefix in /usr/local /opt/homebrew /home/linuxbrew/.linuxbrew ~/.homebrew; do
    if [ -e ${prefix}/bin/brew ]; then
      HOMEBREW_PREFIX=$prefix
      break
    fi
  done
  unset prefix
fi
if [ "${HOMEBREW_PREFIX-}" ] && [ -z "${HOMEBREW_NO-}" ]; then
  export HOMEBREW_NO_AUTO_UPDATE=1
  PATH=${PATH#"${HOMEBREW_PREFIX}"/bin:}
  eval "$("${HOMEBREW_PREFIX}"/bin/brew shellenv)"
fi

PERL5LIBLOCAL="${HOME}/local/lib/perl5"
export PERL_CPANM_OPT="--local-lib=${PERL5LIBLOCAL}"
export PERL5LIB="${PERL5LIBLOCAL}/lib/perl5"

UV_PYTHON=3.14
export WORKON_HOME="${HOME}/.virtualenvs"
if [ -d "${VIRTUAL_ENV:=${WORKON_HOME}/${UV_PYTHON}}" ]; then
  export VIRTUAL_ENV
  PATH=${VIRTUAL_ENV}/bin:$PATH
fi
export UV_PYTHON_INSTALL_BIN=0
export STATSMODELS_DATA="${HOME}/.cache/statsmodels"

export GOPATH="${HOME}/.go"
PATH=${GOPATH}/bin:$PATH

PATH=${HOME}/.cargo/bin:$PATH

PATH=${UCSC_KENT_BIN:=${HOME}/.ucsc-kent/bin}:$PATH
export UCSC_KENT_BIN

: "${XDG_CONFIG_HOME:=${HOME}/.config}"
export XDG_CONFIG_HOME
PATH=${XDG_BIN_HOME:-${HOME}/.local/bin}:$PATH
PATH=${XDG_DATA_HOME:-${HOME}/.local/share}/mise/shims:$PATH

PATH=${HOME}/local/bin:${HOME}/.config/bin:$PATH

export LANG=C
export LC_CTYPE=en_US.UTF-8

export EDITOR=vim
export PAGER=less
export LESS='-RSj3'
export LESSHISTFILE=-

. ~/.config/dircolors/ls_colors.sh 2>/dev/null || :
export LSCOLORS='ExGxcxdxCxegedabagacadah'

export CMAKE_EXPORT_COMPILE_COMMANDS=1
export TEXMFHOME="${HOME}/.texmf"

[ -f ~/.site.profile ] && . ~/.site.profile
