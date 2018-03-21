#!/bin/sh
WINDOW=$(date +note%Y%m%d)
if tmux has-session >/dev/null 2>&1; then
    tmux new-window -d -n ${WINDOW} -c ~
else
    tmux new-session -d -n ${WINDOW} -c ~
fi
tmux split-window -h -c ~ -t ${WINDOW}
tmux split-window -v -c ~ -t ${WINDOW}.0
tmux split-window -v -c ~ -t ${WINDOW}.2

tmux send-keys -t ${WINDOW}.0 ' cd ~/git/offline && npm start' C-m
tmux send-keys -t ${WINDOW}.1 ' cd ~/git/heavywatal.github.io && git pull' C-m
tmux send-keys -t ${WINDOW}.2 ' cd ~/git/offline && git pull' C-m
tmux send-keys -t ${WINDOW}.3 ' cd ~/git/heavywatal.github.io/public && git pull' C-m

if [ "${TMUX}" = "" ]; then
    tmux attach
fi
