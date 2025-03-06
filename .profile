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

export WORKON_HOME="${HOME}/.virtualenvs"
export UV_PYTHON=3.13
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

PATH=${XDG_BIN_HOME:-${HOME}/.local/bin}:$PATH

PATH=${HOME}/local/bin:${HOME}/.config/bin:$PATH

export LANG=C
export LC_CTYPE=en_US.UTF-8

export EDITOR=vim
export PAGER=less
export LESS='-RSj3'
export LESSHISTFILE=-
export BAT_PAGER="less $LESS"

#eval $(dircolors)
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS
export LSCOLORS='ExGxcxdxBxegedabagacad'

export CMAKE_EXPORT_COMPILE_COMMANDS=1
export TEXMFHOME="${HOME}/.texmf"

[ -f ~/.site.profile ] && . ~/.site.profile
