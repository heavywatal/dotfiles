#!/bin/sh
JOBS=("${@/#/ ssh }")
echo "${JOBS[@]}"
tmuxtile.sh "${JOBS[@]}"
tmux set-window-option synchronize-panes on
