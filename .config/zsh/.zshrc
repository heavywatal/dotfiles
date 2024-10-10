autoload ${ZDOTDIR}/functions/*(:t)
fpath+=${ZDOTDIR}/functions
fpath+=${ZDOTDIR}/completions
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
autoload -Uz +X compinit && compinit -C
compdef -d delta

uv() {
  unfunction "$0"
  eval "$(uv generate-shell-completion zsh 2>/dev/null)"
  $0 "$@"
}

rbenv() {
  unfunction "$0"
  eval "$(rbenv init -)"
  $0 "$@"
}

[ -f ~/.bashrc ] && . ~/.bashrc

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%U%d%u%b'

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

#########1#########2#########3#########4#########5#########6#########7#########
## Expansion and Globbing

#setopt BAD_PATTERN
#setopt BARE_GLOB_QUAL
#setopt BRACE_CCL
#setopt CASE_GLOB
#setopt CASE_MATCH
#setopt EQUALS
setopt EXTENDED_GLOB
#unsetopt GLOB_ASSIGN
setopt GLOB_DOTS
setopt GLOB_STAR_SHORT 2>/dev/null
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

HISTFILE=${ZDOTDIR}/.zsh_history
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
#unsetopt INC_APPEND_HISTORY
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
        PCOL=blue
        ;;
    ::1 | 192.168.* | 10.*)
        PCOL=cyan
        ;;
    *)
        PCOL=magenta
        ;;
esac

PWD_FS=$(stat -f -c %T $PWD 2>/dev/null)
if [ "$PWD_FS" != "nfs" ]; then
  precmd () {
    local HEAD STAGED UNSTAGED
    if HEAD="$(git branch --show-current 2>/dev/null)"; then
      : ${HEAD:="$(git describe --tags --exact-match 2>/dev/null)"}
      : ${HEAD:="$(git rev-parse --short HEAD)"}
      git diff --quiet && UNSTAGED="" || UNSTAGED="%F{red}*"
      git diff --cached --quiet && STAGED="" || STAGED="%F{green}*"
      vcs_info_msg_0_="${UNSTAGED}${STAGED}[$HEAD]"
    else
      vcs_info_msg_0_=""
    fi
  }
fi
unset PWD_FS

PROMPT="%B%F{${PCOL}}%D{%m-%d} %T %n@%m:%~%b \${vcs_info_msg_0_}%f
%# "
unset PCOL

#########1#########2#########3#########4#########5#########6#########7#########
# Alias

alias -g B='| bat'
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
# override expand-or-complete
bindkey '^I' complete-word
# override kill-whole-line
bindkey "^U" backward-kill-line
# history
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

command -v fzf >/dev/null && FZF_ALT_C_COMMAND= eval "$(fzf --zsh)"
