[ -f ~/.bashrc ] && . ~/.bashrc

autoload -Uz is-at-least

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
brew_prefix=$(brew --prefix 2>/dev/null)
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
if is-at-least 5.2; then
  setopt GLOB_STAR_SHORT
fi
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

# SGE_CLUSTER_NAME is not empty on SHIROKANE
if is-at-least 4.3.10 && [ -z "$SGE_CLUSTER_NAME" ]; then
  autoload -Uz vcs_info
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd vcs_info
  zstyle ':vcs_info:*' enable git hg
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' unstagedstr "%F{red}*"
  zstyle ':vcs_info:*' stagedstr "%F{green}*"
  zstyle ':vcs_info:*' formats '%u%c[%b]'
  zstyle ':vcs_info:*' actionformats '%u%c[%b|%a]'
fi

PROMPT="%B%F{${PCOL}}%D{%m-%d} %T %n@%m:%~%b \${vcs_info_msg_0_}%f
%# "
unset PCOL

#########1#########2#########3#########4#########5#########6#########7#########
# Alias

alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'

#########1#########2#########3#########4#########5#########6#########7#########
## Keybind

# emacs-like
bindkey -e
# fn-delete
bindkey "^[[3~" delete-char
# override kill-whole-line
bindkey "^U" backward-kill-line
# history
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

#########1#########2#########3#########4#########5#########6#########7#########
## Window title

precmd(){
    print -Pn "\e]0;%m:%~\a"
}

# This breaks lesspipe
# preexec(){
#     print -Pn "\e]0;%m%# $1 [%~]\a"
# }
