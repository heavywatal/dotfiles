#########1#########2#########3#########4#########5#########6#########7#########
## Interactive Shell Environment

# GNOME:xterm, Terminal.app:xterm-256color, iTerm:xterm-256color
[ ${TERM} = xterm ] && export TERM=xterm-256color

tmux has-session >/dev/null 2>&1 && if [ -z "${TMUX}" ]; then
    echo '% tmux list-sessions'
    tmux list-sessions
    echo '% tmux list-windows -a'
    tmux list-windows -a
fi

#########1#########2#########3#########4#########5#########6#########7#########
## Environment variables

export PAGER=less
export EDITOR=emacs
export EDOTDIR=${HOME}/.emacs.d

MANPATH=/usr/local/man:/usr/local/share/man:${MANPATH}
MANPATH=/opt/local/man:/opt/local/share/man:${MANPATH}
if [ -n "${brew_prefix}" ]; then
    MANPATH=${brew_prefix}/share/man:${MANPATH}
    MANPATH=${brew_prefix}/opt/coreutils/libexec/gnuman:${MANPATH}
    if [ $(uname) = Darwin ]; then
        export HOMEBREW_CC=clang
    fi
fi
export MANPATH

# C-w, M-b, M-f; default: *?_-.[]~=/&;!#$%^(){}<>
WORDCHARS='*?[]~&!#$%^(){}<>'

export LESS='-RSj4'
export LESSHISTFILE=-
eval $(lesspipe.sh 2>/dev/null || lesspipe 2>/dev/null)

export TEXMFHOME=${HOME}/.texmf

#########1#########2#########3#########4#########5#########6#########7#########
## Colors

#eval $(dircolors)
#LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS
# removed mh=00 and ca=38;41 for MEME (depending on csh)

#########1#########2#########3#########4#########5#########6#########7#########
## Changing Directories

#unsetopt AUTO_CD
setopt AUTO_PUSHD
#unsetopt CDABLE_VARS
setopt CHASE_LINKS
setopt POSIX_CD
setopt PUSHD_IGNORE_DUPS
#unsetopt PUSHD_MINUS
#unsetopt PUSHD_SILENT
setopt PUSHD_TO_HOME

#########1#########2#########3#########4#########5#########6#########7#########
## Completion

ZFUNCDIR=${ZDOTDIR}/functions
autoload ${ZFUNCDIR}/*(:t)
fpath=(${ZFUNCDIR} ${fpath})
if [ -d ${brew_prefix}/share/zsh-completions ]; then
    fpath=(${brew_prefix}/share/zsh-completions ${fpath})
fi
unset brew_prefix

autoload -U compinit
compinit -u

if [ -d ${ZDOTDIR}/.zcompcache ]; then
    zstyle ':completion:*' use-cache yes
    zstyle ':completion:*' cache-path ${ZDOTDIR}/.zcompcache
fi

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '%B%U%d%u%b'
zstyle ':completion:*' group-name ''
#
#zstyle ':completion:*' verbose yes
#zstyle ':completion:*:messages' format 'messages: %d'
#zstyle ':completion:*:warnings' format 'No matches for: %d'
#zstyle ':completion:*:options' description 'yes'
#zstyle ':completion:*:cd:*' tag-order local-directories path-directories

#fignore=(.o .dvi .aux .log .toc \~)

#setopt ALWAYS_LAST_PROMPT
#unsetopt ALWAYS_TO_END
#setopt AUTO_LIST
#setopt AUTO_MENU
#unsetopt AUTO_NAME_DIRS
unsetopt AUTO_PARAM_KEYS
unsetopt AUTO_PARAM_SLASH
unsetopt AUTO_REMOVE_SLASH
#unsetopt BASH_AUTO_LIST
#unsetopt COMPLETE_ALIASES
setopt COMPLETE_IN_WORD
setopt GLOB_COMPLETE
#unsetopt HASH_LIST_ALL
#setopt LIST_AMBIGUOUS
unsetopt LIST_BEEP
setopt LIST_PACKED
#unsetopt LIST_ROWS_FIRST
#setopt LIST_TYPES
#unsetopt MENU_COMPLETE
#unsetopt REC_EXACT

compdef sshmux=ssh

#########1#########2#########3#########4#########5#########6#########7#########
## Expansion and Globbing

#setopt BAD_PATTERN
#setopt BARE_GLOB_QUAL
setopt BRACE_CCL
#setopt CASE_GLOB
#setopt CASE_MATCH
#setopt EQUALS
setopt EXTENDED_GLOB
#unsetopt GLOB_ASSIGN
setopt GLOB_DOTS
#unsetopt GLOB_SUBST
#unsetopt HIST_SUBST_PATTERN
#unsetopt IGNORE_BRACES
#unsetopt IGNORE_CLOSE_BRACES
#unsetopt MAGIC_EQUAL_SUBST
#unsetopt MARK_DIRS
#setopt MULTIBYTE
#setopt NOMATCH
#unsetopt NULL_GLOB
setopt NUMERIC_GLOB_SORT
#unsetopt RC_EXPAND_PARAM
#setopt REMATCH_PCRE
#unsetopt SH_GLOB
#setopt UNSET
#unsetopt WARN_CREATE_GLOBAL

#########1#########2#########3#########4#########5#########6#########7#########
## History

HISTFILE=${ZDOTDIR}/.zhistory.$(uname)
HISTSIZE=65535
SAVEHIST=65535

#setopt APPEND_HISTORY
#setopt BANG_HIST
#unsetopt EXTENDED_HISTORY
#unsetopt HIST_ALLOW_CLOBBER
#setopt HIST_BEEP
setopt HIST_EXPIRE_DUPS_FIRST
#unsetopt HIST_FCNTL_LOCK
#unsetopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
#unsetopt HIST_LEX_WORDS
#unsetopt HIST_NO_FUNCTIONS
#unsetopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
#setopt HIST_SAVE_BY_COPY
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
#unsetopt INC_APPEND_HISTORY_TIME
setopt SHARE_HISTORY

#########1#########2#########3#########4#########5#########6#########7#########
## Initialisation

#unsetopt ALL_EXPORT
#unsetopt GLOBAL_EXPORT
#setopt GLOBAL_RCS
#setopt RCS

#########1#########2#########3#########4#########5#########6#########7#########
## Input/Output

#setopt ALIASES
unsetopt CLOBBER
setopt CORRECT
#unsetopt CORRECT_ALL
#unsetopt DVORAK
unsetopt FLOW_CONTROL
setopt IGNORE_EOF
#unsetopt INTERACTIVE_COMMENTS
#setopt HASH_CMDS
#setopt HASH_DIRS
#unsetopt HASH_EXECUTABLES_ONLY
#unsetopt MAIL_WARNING
#unsetopt PATH_DIRS
#unsetopt PATH_SCRIPT
setopt PRINT_EIGHT_BIT
#unsetopt PRINT_EXIT_VALUE
#unsetopt RC_QUOTES
#unsetopt RM_STAR_SILENT
#unsetopt RM_STAR_WAIT
#setopt SHORT_LOOPS

#########1#########2#########3#########4#########5#########6#########7#########
## Job Control

#unsetopt AUTO_CONTINUE
#unsetopt AUTO_RESUME
#setopt BG_NICE
#setopt CHECK_JOBS
#setopt HUP
setopt LONG_LIST_JOBS
#setopt MONITOR
#setopt NOTIFY

#########1#########2#########3#########4#########5#########6#########7#########
## Prompting

#unsetopt PROMPT_BANG
unsetopt PROMPT_CR
#setopt PROMPT_SP
#setopt PROMPT_PERCENT
setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT

autoload -U colors; colors

case $(echo ${SSH_CONNECTION} | awk '{print $3}') in
    '')
        PCOL=white
        ;;
    130.34.106.*)
        PCOL=magenta
        ;;
    10.*)
        PCOL=yellow
        ;;
    *)
        PCOL=cyan
        ;;
esac

PROMPT="%{$fg_bold[${PCOL}]%}%D{%m-%d} %T %n@%m:%~
%{$reset_color%}%# "
#PROMPT="%{$fg_bold[${PCOL}]%}[%m]%{$reset_color%}%# "
#RPROMPT="%{$fg_bold[${PCOL}]%}[%~]%{$reset_color%}"
unset PCOL

#########1#########2#########3#########4#########5#########6#########7#########
## Alias

if ls --color=auto >/dev/null 2>&1; then
    alias ls="ls -vF --show-control-chars --color=auto"
else
    alias ls="ls -FG"
fi

alias ll="ls -l"
alias lal="ls -al"
alias rm='nocorrect rm -i'
alias mv='nocorrect mv -i'
alias cp='nocorrect cp -i'
alias mkdir='nocorrect mkdir'
alias touch='nocorrect touch'
alias grep='grep --binary-files=without-match --color=auto'
alias gd='dirs -v; read newdir; cd +"${newdir}"' #選択的popd
alias R='R --quiet --no-save --no-restore-data'
alias em='emacs -nw'
alias rsync='rsync --exclude-from=${HOME}/.config/rsync-exclude'
alias ta="tmux -2u attach"
alias diffu='colordiff -u'

if [ $(uname) = Darwin ]; then
    alias ldd="otool -L"
    alias wine=/Applications/Wine.app/Contents/Resources/bin/wine
    alias mi="open -a mi"
    alias memacs='open -a emacs'
    alias pbsnodes="ssh charles pbsnodes"
fi

alias mrsh="python -m remote"
alias apt-upgradable="apt-get -s upgrade | grep Inst | cut -f2 -d' '"

#########1#########2#########3#########4
# Global

alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'

#########1#########2#########3#########4#########5#########6#########7#########
## Keybind

# emacs-like
bindkey -e
# delete
bindkey "^[[3~" delete-char
# home/end
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
# PageUp/PageDown
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
# History
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
# override kill-whole-line
bindkey "^U" backward-kill-line

#########1#########2#########3#########4#########5#########6#########7#########
## Window title

precmd(){
    print -Pn "\e]0;%m:%~\a"
}

# This breaks lesspipe
# preexec(){
#     print -Pn "\e]0;%m%# $1 [%~]\a"
# }

#########1#########2#########3#########4#########5#########6#########7#########
## Python

export PYTHONSTARTUP=${HOME}/local/lib/python/pythonstartup.py

source ${HOME}/.virtualenv/py3/bin/activate 2>/dev/null && MANPATH=${MANPATH}:${VIRTUAL_ENV}/man:${VIRTUAL_ENV}/share/man

export GOPATH=${HOME}/.go
