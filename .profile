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

PATH=${HOME}/.cargo/bin:$PATH

export GOPATH=${HOME}/.go
PATH=${GOPATH}/bin:$PATH

export HUGO_MODULE_REPLACEMENTS="\
github.com/heavywatal/hugo-theme-nonblog -> ${HOME}/git/hugo-theme-nonblog,
github.com/heavywatal/hugo-theme-reveal -> ${HOME}/git/hugo-theme-reveal,
github.com/heavywatal/hugo-mod-common -> ${HOME}/git/hugo-mod-common"

PERL5LIBLOCAL="${HOME}/local/lib/perl5"
export PERL_CPANM_OPT="--local-lib=${PERL5LIBLOCAL}"
export PERL5LIB="${PERL5LIBLOCAL}/lib/perl5"

export PYENV_ROOT=${HOME}/.pyenv
if [ -d $PYENV_ROOT ]; then
    pyenv_versions=(${PYENV_ROOT}/versions/*)
    pyenv_latest=${pyenv_versions[@]: -1}/bin
    PATH=${pyenv_latest}:$PATH
    export PYENV_PYTHONPATH=${pyenv_latest}/python3
    unset pyenv_versions pyenv_latest
fi
PATH=$(python3 -m site --user-base)/bin:$PATH

PATH=${HOME}/local/bin:${HOME}/.config/bin:$PATH
export PATH
export MANPATH

# Language
export LANG=C
export LC_CTYPE=en_US.UTF-8
