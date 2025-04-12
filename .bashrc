#!/bin/bash

[ "${-%%*i*}" ] && return 0

if [ "${TMUX-}" ]; then
  [ -z "${SSH_CONNECTION-}" ] && eval "$(tmux showenv TERM_PROGRAM)"
  echo -ne "\e[1 q"
  # workaround for tmux on vscode terminal
  eval "$(tmux showenv TERM)"
  # vim cannot understand screen-256color
else
  tmux list-sessions 2>/dev/null
fi
export LC_TERMINAL=${LC_TERMINAL:-$TERM_PROGRAM}

export NVM_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export FZF_DEFAULT_COMMAND='fd --strip-cwd-prefix --hidden --follow --exclude ".git"'
export FZF_DEFAULT_OPTS="--preview-window=hidden,down,border-horizontal"
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=ctrl-j:accept,ctrl-k:kill-line,?:toggle-preview"
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=16"
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --tmux=top,100%,95%"
FZF_COMPLETION_OPTS="--ansi --preview='bat --color=always --theme=${BAT_THEME_FZF-ansi} {} 2>/dev/null || lsd -al --color=always {}'"
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --color=always"
FZF_CTRL_T_OPTS="$FZF_COMPLETION_OPTS"
FZF_CTRL_T_OPTS="$FZF_CTRL_T_OPTS --bind='ctrl-/:reload($FZF_CTRL_T_COMMAND --type d)'"
FZF_CTRL_T_OPTS="$FZF_CTRL_T_OPTS --bind='ctrl-t:reload($FZF_CTRL_T_COMMAND --type f)'"
FZF_CTRL_R_OPTS="--preview='bat --color=always --theme=${BAT_THEME_FZF-ansi} -pl sh <<< {2..}' --preview-window=bottom,3,wrap"
FZF_ALT_C_COMMAND=

_fzf_compgen_path() {
  fd --color=always --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --color=always --type d --hidden --follow --exclude ".git" . "$1"
}


if command -v lsd >/dev/null; then
    # shellcheck disable=SC2262
    alias ls='lsd'
    alias tree="lsd --tree --color=always"
elif command -v gls >/dev/null; then
    alias ls='gls -vF --color=auto'
elif ls --version >/dev/null 2>&1; then
    alias ls='ls -vF --color=auto'
else
    alias ls='ls -FG'
fi

alias ll="ls -l"
alias lal="ls -al"
alias diffu='diff --color=always -u'
alias giff='git diff --no-index'
alias zmux='SHELL=$(which zsh) exec tmux'
alias r='R --quiet --no-save --no-restore-data'
alias luatexmk='latexmk -lualatex'
alias samview='samtools view -h --no-PG'
alias eza="eza -gBF --time-style long-iso --icons=auto --color-scale=all"

if command -v zstd >/dev/null; then
  alias zcat='zstdcat'
  alias zless='zstdless'
  alias zgrep='zstdgrep'
fi

if [ "$(uname)" = Darwin ]; then
  alias ql="qlmanage -p"
  alias ldd="otool -L"
fi

if [ "${BASH-}" ]; then
  PS1='\[\e[1;34m\]\D{%m-%d} \A \u@\h:\w\[\e[0m\]\n\$ '

  # Do not exit with ctrl-d
  set -o ignoreeof

  eval "$(fzf --bash 2>/dev/null)"
fi

[ -f ~/.site.bashrc ] && . ~/.site.bashrc
