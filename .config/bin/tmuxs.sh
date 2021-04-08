#!/bin/bash
JOBS=("${@/#/ssh }")
tmuxtile.sh "${JOBS[@]}"
tmux set-option -w synchronize-panes on
