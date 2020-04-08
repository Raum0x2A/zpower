if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    tmux has-session -t remote 2>/dev/null
    if [ $? != 0 ]; then
    	    exec tmux new-session -s remote
    else
	    exec tmux attach-session -t remote
    fi
fi
if [ "$SSH_CONNECTION" != "" ]; then
	tmux source-file $HOME/.tmux.conf.ssh
else
	tmux source-file $HOME/.tmux.conf
fi
