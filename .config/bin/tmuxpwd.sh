#!/bin/sh
SESSION="${TERM_PROGRAM}-$(basename $PWD | tr . _)"
tmux new-session -A -s $SESSION -c $PWD
