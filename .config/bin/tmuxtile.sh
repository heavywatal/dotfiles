#!/bin/bash
[ $# -lt 2 ] && exit
WINDOW=$(date +tile%Y%m%d)
if tmux has-session >/dev/null 2>&1; then
    tmux new-window -d -n ${WINDOW}
else
    tmux new-session -d -n ${WINDOW}
fi

for i in "${@:2}"; do
    tmux split-window -t ${WINDOW}
    tmux select-layout -t ${WINDOW} tiled
done
# layout each time to avoid "create pane failed: pane too small"

JOBS=("$@")
for i in "${!JOBS[@]}"; do
    echo "${WINDOW}.$i: ${JOBS[$i]}"
    tmux send-keys -t ${WINDOW}.$i " ${JOBS[$i]}" C-m
done

if [ -z "${TMUX}" ]; then
    tmux attach-session
fi
