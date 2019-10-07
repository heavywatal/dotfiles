#!/bin/sh
SESSION="${TERM_PROGRAM}-$(basename $(pwd))"
tmux attach-session -d -t $SESSION || tmux new-session -s $SESSION
