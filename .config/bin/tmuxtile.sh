#!/bin/bash
[ $# -lt 2 ] && exit
WINDOW=$(date +tile%Y%m%d)
while tmux list-windows -a -F "#{window_name}" | grep "^${WINDOW}$"; do
    WINDOW=${WINDOW}_
done
if [ -z "$TMUX" ]; then
    tmux new-session -d -n "$WINDOW" -s "$WINDOW"
else
    tmux new-window -d -n "$WINDOW"
fi

for i in "${@:2}"; do
    tmux split-window -t "$WINDOW"
    tmux select-layout -t "$WINDOW" tiled
done
# layout each time to avoid "create pane failed: pane too small"

JOBS=("$@")
for i in "${!JOBS[@]}"; do
    echo "${WINDOW}.$i: ${JOBS[$i]}" 1>&2
    tmux send-keys -t "${WINDOW}.$i" " ${JOBS[$i]}" C-m
done

if [ -z "$TMUX" ]; then
    tmux attach-session -t "$WINDOW"
fi
tmux select-window -t "$WINDOW"
