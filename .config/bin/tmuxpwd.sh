#!/bin/sh
SESSION=$(basename "$PWD" | tr . _)
tmux new-session -A -s "$SESSION" -c "$PWD"
