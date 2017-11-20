if [ -n "$1" ]; then
    ssh -t $* "tmux -2u attach -d || tmux -2u"
else
    echo "$0: missing hostname"
    return 1
fi
