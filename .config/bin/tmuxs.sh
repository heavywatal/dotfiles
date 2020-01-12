#!/bin/bash
JOBS=("${@/#/ ssh }")
echo "${JOBS[@]}"
tmuxtile.sh "${JOBS[@]}"
tmux set-option -w synchronize-panes on
