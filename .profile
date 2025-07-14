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
    PATH=/usr/bin:/bin
    [ -f /etc/environment ] && . /etc/environment
    [ -f /etc/profile ] && . /etc/profile
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

UV_PYTHON=3.13
export WORKON_HOME="${HOME}/.virtualenvs"
if [ -d "${VIRTUAL_ENV:=${WORKON_HOME}/${UV_PYTHON}}" ]; then
  export VIRTUAL_ENV
  PATH=${VIRTUAL_ENV}/bin:$PATH
fi

export GOPATH="${HOME}/.go"
PATH=${GOPATH}/bin:$PATH

PATH=${HOME}/.cargo/bin:$PATH

PATH=${UCSC_KENT_BIN:=${HOME}/.ucsc-kent/bin}:$PATH
export UCSC_KENT_BIN

PATH=${XDG_BIN_HOME:-${HOME}/.local/bin}:$PATH

PATH=${HOME}/local/bin:${HOME}/.config/bin:$PATH

export LANG=C
export LC_CTYPE=en_US.UTF-8

export EDITOR=vim
export PAGER=less
export LESS='-RSj3'
export LESSHISTFILE=-
export BAT_PAGER="less $LESS"

#eval $(dircolors -b ~/.config/dircolors/colorrc)
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.gz=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.7z=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mp3=00;36:*.ogg=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.tmp=00;90:';
export LS_COLORS
export LSCOLORS='ExGxcxdxCxegedabagacadah'

export CMAKE_EXPORT_COMPILE_COMMANDS=1
export TEXMFHOME="${HOME}/.texmf"

[ -f ~/.site.profile ] && . ~/.site.profile
