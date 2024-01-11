if [ -n "$BASH" ]; then
    # Source global definitions
    [ -f /etc/bashrc ] && . /etc/bashrc

    # PROMPT
    [ -z "$PS1" ] && return
    PS1='\e[1;34m[\D{%m-%d} \A \u@\h:\w]\e[0m\n\$ '

    # Do not exit with ctrl-d
    IGNOREEOF=10
fi

#########1#########2#########3#########4#########5#########6#########7#########
## Environment variables

export PAGER=less
export EDITOR=vim
export EDOTDIR=${HOME}/.emacs.d

# C-w, M-b, M-f; default: *?_-.[]~=/&;!#$%^(){}<>
WORDCHARS='*?[]~&!#$%^(){}<>'

export LESS='-RSj3'
export LESSHISTFILE=-
export BAT_PAGER="less $LESS"

#eval $(dircolors)
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

export TEXMFHOME=${HOME}/.texmf
export PIP_CONFIG_FILE=${HOME}/.config/python/pip.conf

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

rbenv() {
  unfunction "$0"
  eval "$(rbenv init -)"
  $0 "$@"
}

if [ -n "$TMUX" ]; then
  [ -z "$SSH_CONNECTION" ] && eval $(tmux showenv TERM_PROGRAM)
  echo -ne "\e[1 q"
  # workaround for tmux on vscode terminal
else
  tmux has-session >/dev/null 2>&1 && tmux list-sessions
fi

export LC_TERMINAL=${LC_TERMINAL:-$TERM_PROGRAM}

uistyle() {
  local UISTYLE=${1:-$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo Light)}
  export DELTA_FEATURES=$UISTYLE
  [ "$LC_TERMINAL" = "iTerm2" ] && echo -e "\033]50;SetProfile=${UISTYLE}\a"
}

#########1#########2#########3#########4#########5#########6#########7#########
## Alias

if command -v lsd >/dev/null; then
    alias ls='lsd'
    alias tree="lsd --tree --color=always"
elif command -v gls >/dev/null; then
    alias ls='gls -vF --color=auto'
elif ls --version >/dev/null 2>&1; then
    alias ls='ls -vF --color=auto'
else
    export LSCOLORS='ExGxcxdxBxegedabagacad'
    alias ls='ls -FG'
fi

alias ll="ls -l"
alias lal="ls -al"
alias rmi='rm -i'
alias mvi='mv -i'
alias cpi='cp -i'
alias gd='dirs -v; read newdir; cd +"${newdir}"'  # interactive popd
alias cgrep='grep --color=always'
alias diffu='diff --color=always -u'
alias giff='git diff --no-index'
alias ta="tmux -2u attach"
alias zmux='SHELL=$(which zsh) exec tmux'
alias r='R --quiet --no-save --no-restore-data'
alias luatexmk='latexmk -lualatex'
alias samview='samtools view -h --no-PG'
alias tv='tidy-viewer'

if [ $(uname) = Darwin ]; then
    alias ql="qlmanage -p $@ >/dev/null 2>&1"
    alias ldd="otool -L"
    uistyle
fi

[ -f ~/.bashrc.site ] && . ~/.bashrc.site
