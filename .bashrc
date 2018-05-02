if [ "${0##*/}" = "bash" ]; then
    # Source global definitions
    [ -f /etc/bashrc ] && . /etc/bashrc

    # PROMPT
    #PS1='[\u@\h \W]\$ '
    PS1='\e[1;34m[\D{%m-%d} \A \u@\h:\w]\e[0m\n\$ '

    IGNOREEOF=10
fi

#########1#########2#########3#########4#########5#########6#########7#########
## Environment variables

export PAGER=less
export EDITOR=emacs
export EDOTDIR=${HOME}/.emacs.d

MANPATH=/usr/local/man:/usr/local/share/man:${MANPATH}
MANPATH=/opt/local/man:/opt/local/share/man:${MANPATH}
export MANPATH

# C-w, M-b, M-f; default: *?_-.[]~=/&;!#$%^(){}<>
WORDCHARS='*?[]~&!#$%^(){}<>'

export LESS='-RSj4'
export LESSHISTFILE=-

#eval $(dircolors)
#LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS
# removed mh=00 and ca=38;41 for MEME (depending on csh)

export TEXMFHOME=${HOME}/.texmf
export PYTHONSTARTUP=${HOME}/.config/python/startup.py
export PIP_CONFIG_FILE=${HOME}/.config/pip/pip.conf

tmux has-session >/dev/null 2>&1 && if [ -z "${TMUX}" ]; then
    echo '% tmux list-sessions'
    tmux list-sessions
    echo '% tmux list-windows -a'
    tmux list-windows -a
fi

#########1#########2#########3#########4#########5#########6#########7#########
## Alias

if ls --color=auto >/dev/null 2>&1; then
    alias ls="ls -vF --show-control-chars --color=auto"
else
    alias ls="ls -FG"
fi

alias rsync='rsync --exclude-from=${HOME}/.config/rsync-exclude'

alias rmi='rm -i'
alias mvi='mv -i'
alias cpi='cp -i'
alias ll="ls -l"
alias lal="ls -al"
alias gd='dirs -v; read newdir; cd +"${newdir}"'  # interactive popd
alias cgrep='grep --color=always'
alias diffu='diff --color=always -u'
alias giff='git diff --no-index'
alias ta="tmux -2u attach"
alias zmux='SHELL=$(which zsh) exec tmux'
alias r='R --quiet --no-save --no-restore-data'
alias clang++14='clang++ -std=c++14 -Wall -Wextra -Wpedantic'
alias with-homelib='CPATH=${HOME}/local/include LIBRARY_PATH=${HOME}/local/lib64:${HOME}/local/lib LD_LIBRARY_PATH=${HOME}/local/lib64:${HOME}/local/lib'
alias rmcmake='rm -r CMakeCache.txt CMakeFiles CTestTestfile.cmake DartConfiguration.tcl Makefile Testing cmake_install.cmake compile_commands.json install_manifest.txt'

if [ $(uname) = Darwin ]; then
    alias ql="qlmanage -p $@ >/dev/null 2>&1"
    alias ldd="otool -L"
    alias wine=/Applications/Wine.app/Contents/Resources/bin/wine
else
    alias apt-upgradable="apt-get -s upgrade | grep Inst | cut -f2 -d' '"
fi

[ -f ~/.bashrc.site ] && . ~/.bashrc.site
