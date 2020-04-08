if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" = "" ]; then
    tmux has-session -t $(tty | sed 's/^.....//') 2>/dev/null
    if [ $? != 0 ]; then
    	    exec tmux new-session -s $(tty | sed 's/^.....//')
    else
	    exec tmux attach-session -t $(tty | sed 's/^.....//')
    fi
fi
