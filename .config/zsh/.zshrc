autoload ${ZDOTDIR}/functions/*(:t)
fpath+=${ZDOTDIR}/functions
fpath+=${ZDOTDIR}/completions
if [ "${HOMEBREW_PREFIX-}" ] && [ -z "${HOMEBREW_NO-}" ]; then
  fpath+=${HOMEBREW_PREFIX}/share/zsh/site-functions
  fpath+=${HOMEBREW_PREFIX}/share/zsh-completions
fi
fpath+=/Applications/OrbStack.app/Contents/Resources/completions/zsh

autoload -Uz +X compinit && compinit -C
compdef -d delta

uv() {
  unfunction "$0"
  eval "$(uv generate-shell-completion zsh 2>/dev/null)"
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

#setopt AUTO_CD
setopt AUTO_PUSHD
#setopt CDABLE_VARS
#setopt CD_SILENT
#setopt CHASE_DOTS
setopt CHASE_LINKS
setopt POSIX_CD
setopt PUSHD_IGNORE_DUPS
#setopt PUSHD_MINUS
#setopt PUSHD_SILENT
#setopt PUSHD_TO_HOME

#########1#########2#########3#########4#########5#########6#########7#########
## Completion

ZLE_REMOVE_SUFFIX_CHARS=

#setopt NO_ALWAYS_LAST_PROMPT
#setopt ALWAYS_TO_END
#setopt NO_AUTO_LIST
#setopt NO_AUTO_MENU
#setopt AUTO_NAME_DIRS
#setopt NO_AUTO_PARAM_KEYS
#setopt NO_AUTO_PARAM_SLASH
#setopt NO_AUTO_REMOVE_SLASH
#setopt BASH_AUTO_LIST
#setopt COMPLETE_ALIASES
setopt COMPLETE_IN_WORD
setopt GLOB_COMPLETE
#setopt NO_HASH_LIST_ALL
#setopt NO_LIST_AMBIGUOUS
setopt NO_LIST_BEEP
setopt LIST_PACKED
#setopt LIST_ROWS_FIRST
#setopt NO_LIST_TYPES
#setopt MENU_COMPLETE
#setopt REC_EXACT

#########1#########2#########3#########4#########5#########6#########7#########
## Expansion and Globbing

# C-w, M-b, M-f; default: *?_-.[]~=/&;!#$%^(){}<>
WORDCHARS='*_-[]~!#$%^(){}<>'

#setopt BAD_PATTERN
#setopt BARE_GLOB_QUAL
#setopt BRACE_CCL
#setopt NO_CASE_GLOB
#setopt NO_CASE_MATCH
#setopt CASE_PATHS
#setopt CSH_NULL_GLOB
#setopt EQUALS
setopt EXTENDED_GLOB
#setopt FORCE_FLOAT
#setopt NO_GLOB
#setopt GLOB_ASSIGN
setopt GLOB_DOTS
setopt GLOB_STAR_SHORT 2>/dev/null
#setopt GLOB_SUBST
#setopt HIST_SUBST_PATTERN
#setopt IGNORE_BRACES
#setopt IGNORE_CLOSE_BRACES
#setopt KSH_GLOB
#setopt MAGIC_EQUAL_SUBST
#setopt MARK_DIRS
#setopt NO_MULTIBYTE
#setopt NOMATCH
#setopt NULL_GLOB
setopt NUMERIC_GLOB_SORT
#setopt RC_EXPAND_PARAM
#setopt REMATCH_PCRE
#setopt SH_GLOB
#setopt UNSET
#setopt WARN_CREATE_GLOBAL
#setopt WARN_NESTED_VAR

#########1#########2#########3#########4#########5#########6#########7#########
## History

HISTFILE=${ZDOTDIR}/.zsh_history
HISTSIZE=65535
SAVEHIST=65535

#setopt NO_APPEND_HISTORY
#setopt BANG_HIST
#setopt EXTENDED_HISTORY
#setopt HIST_ALLOW_CLOBBER
#setopt NO_HIST_BEEP
setopt HIST_EXPIRE_DUPS_FIRST
#setopt HIST_FCNTL_LOCK
#setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
#setopt HIST_LEX_WORDS
#setopt HIST_NO_FUNCTIONS
#setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
#setopt NO_HIST_SAVE_BY_COPY
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
#setopt INC_APPEND_HISTORY
#setopt INC_APPEND_HISTORY_TIME
setopt SHARE_HISTORY

#########1#########2#########3#########4#########5#########6#########7#########
## Initialisation

#setopt ALL_EXPORT
#setopt GLOBAL_EXPORT
#setopt NO_GLOBAL_RCS
#setopt NO_RCS

#########1#########2#########3#########4#########5#########6#########7#########
## Input/Output

#setopt NO_ALIASES
setopt NO_CLOBBER
setopt CORRECT
#setopt CORRECT_ALL
#setopt DVORAK
setopt NO_FLOW_CONTROL
setopt IGNORE_EOF
#setopt INTERACTIVE_COMMENTS
#setopt NO_HASH_CMDS
#setopt NO_HASH_DIRS
#setopt HASH_EXECUTABLES_ONLY
#setopt MAIL_WARNING
#setopt PATH_DIRS
#setopt PATH_SCRIPT
setopt PRINT_EIGHT_BIT
#setopt PRINT_EXIT_VALUE
#setopt RC_QUOTES
#setopt RM_STAR_SILENT
#setopt RM_STAR_WAIT
#setopt SHORT_LOOPS
#setopt SHORT_REPEAT

#########1#########2#########3#########4#########5#########6#########7#########
## Job Control

#setopt AUTO_CONTINUE
#setopt AUTO_RESUME
#setopt BG_NICE
#setopt CHECK_JOBS
#setopt CHECK_RUNNING_JOBS
#setopt HUP
setopt LONG_LIST_JOBS
#setopt MONITOR
#setopt NOTIFY
#setopt POSIX_JOBS

#########1#########2#########3#########4#########5#########6#########7#########
## Prompting

#setopt PROMPT_BANG
setopt NO_PROMPT_CR
#setopt NO_PROMPT_SP
#setopt PROMPT_PERCENT
setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT

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

ssh_conn=(${=SSH_CONNECTION})
case ${ssh_conn[3]} in
    ::1 | 192.168.* | 10.* | 169.254.* | fe80:*)
        P_COLOR=cyan ;;
    '') P_COLOR=blue ;;
    *)  P_COLOR=magenta ;;
esac
unset ssh_conn

PROMPT="%B%F{${P_COLOR}}%D{%m-%d} %T %n@%m:%~%b \${vcs_info_msg_0_}%f
%# "
unset P_COLOR

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

source <(fzf --zsh 2>/dev/null)
