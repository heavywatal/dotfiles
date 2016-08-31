# Source global definitions
if [ -f /etc/bashrc ]; then
 	    . /etc/bashrc
fi

# PROMPT
#PS1='[\u@\h \W]\$ '
PS1='\e[1;34m[\D{%m-%d} \A \u@\h:\w]\e[0m\n\$ '

alias zmux='SHELL=$(brew --prefix)/bin/zsh exec tmux
