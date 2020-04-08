# Test
alias alias-test='echo Aliases are working'

# Ubunut package manager
alias sys-update='sudo apt update && sudo apt upgrade && sudo apt autoremove'
alias get='sudo apt install'
alias get-snap='sudo snap install'
alias find-snap='snap search'

# System power
alias restart='sudo reboot now'
alias pwroff='sudo shutdown -h'
alias offnow='sudo shutdown -h now'

# ZSH
alias edit-alias='vim $HOME/.config/zsh/aliases.zsh'
alias zshcfg='vim $HOME/.zshrc'

# Tmux
alias tmux='tmux -2'

# Enhanced standard commands
alias cls='clear && ls' # Wish windows cls worked like this...
alias rmr="rm -r"       # Better than rmdir... I'm that kind of lazy
alias c='clear'

# Other
alias dl="aria2c"
alias torrent="aria2c --seed-time=0"
alias msh='mosh'
alias rs="rsync"
