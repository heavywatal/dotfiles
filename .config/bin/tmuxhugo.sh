#!/bin/sh
WINDOW=$(date +note%Y%m%d)
if tmux has-session >/dev/null 2>&1; then
    tmux new-window -d -n ${WINDOW} -c ~/git/offline
else
    tmux new-session -d -n ${WINDOW} -c ~/git/offline
fi
tmux split-window -t ${WINDOW} -c ~/git/offline
tmux split-window -t ${WINDOW} -c ~/git/heavywatal.github.io
tmux split-window -t ${WINDOW} -c ~/git/heavywatal.github.io/public

tmux select-layout -t ${WINDOW} tiled

tmux send-keys -t ${WINDOW}.0 'npm start' C-m
tmux send-keys -t ${WINDOW}.1 'git pull' C-m
tmux send-keys -t ${WINDOW}.2 'git pull' C-m
tmux send-keys -t ${WINDOW}.3 'git pull' C-m

if [ -z "${TMUX}" ]; then
    tmux attach-session
fi
