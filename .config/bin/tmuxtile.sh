#!/bin/bash
set -eu
[ $# -lt 2 ] && exit
WINDOW=$(date +tile%Y%m%d)
while tmux list-windows -a -F "#{window_name}" | grep "^${WINDOW}$"; do
    WINDOW=${WINDOW}_
done
if [ "${TMUX-}" ]; then
    tmux new-window -d -n "$WINDOW"
else
    tmux new-session -d -n "$WINDOW" -s "$WINDOW"
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

if [ "${TMUX-}" ]; then
    tmux select-window -t "$WINDOW"
else
    tmux attach-session -t "$WINDOW"
fi
