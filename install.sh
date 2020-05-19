#!/bin/bash
if ! hash dialog 2>/dev/null; then
    echo "dialog is not installed"
    exit
fi

working() {
	tskpid=$!
	statustxt=$1
	echo -ne "$statustxt\r"
	while kill -0 $tskpid 2>/dev/null; do
		echo -ne "$statustxt [*---]\r"; sleep 0.2
		echo -ne "\r\033[K"
		echo -ne "$statustxt [-*--]\r"; sleep 0.2
		echo -ne "\r\033[K"
		echo -ne "$statustxt [--*-]\r"; sleep 0.2
		echo -ne "\r\033[K"
		echo -ne "$statustxt [---*]\r"; sleep 0.2
		echo -ne "\r\033[K"
		echo -ne "$statustxt [--*-]\r"; sleep 0.2
		echo -ne "\r\033[K"
		echo -ne "$statustxt [-*--]\r"; sleep 0.2
		echo -ne "\r\033[K"
	done
	echo "$statustxt [Done]"
}

usrhome=$HOME
SHELL_TEST=$(basename "$SHELL")

funcheck=(dialog --title "ZPower Installer v2" --radiolist "Select the groups they belong:" 0 0 0)
options=(1 "Desktop Edition" on 2 "Server Edition" off)
selections=$("${funcheck[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for selection in $selections
do
	case $selection in
		1)
			echo "Starting Desktop edition install"
			zde=1
			zse=0
			;;
		2)
			echo "Starting Server edition install"
			zse=1
			zde=0
			;;
	esac
done

# Update/upgrade ubuntu repos
echo "Updating Ubuntu repos..."
sudo apt -qq update -y && sudo apt -qq upgrade -y || echo "apt update failed"

# Install packages from Ubuntu repos
if [ $zse -eq 1 ]; then
	sudo apt -qq install -y curl git zsh tmux powerline || echo "apt install failed"
else
	sudo apt -qq install -y curl git zsh powerline || echo "apt install failed"
fi

# Create directories
mkdir -m 755 -p $usrhome/.config/zsh/ $usrhome/.config/zsh/plugins $usrhome/.config/zsh/themes & working "Creating folders"

# Clone git repos
## Oh-My-TMUX (framework)
if [ $zse -eq 1 ]; then
	git clone --quiet https://github.com/gpakosz/.tmux.git $usrhome/.tmux & working "Cloning Oh-My-TMUX"
fi

## Oh-My-ZSH (framework)
git clone --quiet --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $usrhome/.oh-my-zsh & working "Cloning Oh-My-ZSH"
## ZSH Auto-Suggestions (plugin)
git clone --quiet https://github.com/zsh-users/zsh-autosuggestions.git $usrhome/.config/zsh/plugins/zsh-autosuggestions & working "Cloning zsh-autosuggestions"
## ZSH Syntax-highlighting (plugin)
git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git $usrhome/.config/zsh/plugins/zsh-syntax-highlighting & working "Cloning zsh-syntax-highlighting"
## Powerlevel10k (zsh-theme)
git clone --quiet https://github.com/romkatv/powerlevel10k.git $usrhome/.config/zsh/themes/powerlevel10k & working "Cloning powerlevel10k"

# backup .zshrc
if [ -f $usrhome/.zshrc ] || [ -h $usrhome/.zshrc ]; then
        echo Backing up $usrhome/.zshrc
        mv $usrhome/.zshrc $usrhome/.zshrc.backup
fi

# copy config files
echo "Installing config files"
## zshrc > $HOME/.zshrc
cp files/zshrc $usrhome/.zshrc
## aliases.zsh > $HOME/.config/zsh/aliases.zsh
cp files/aliases.zsh $usrhome/.config/zsh/aliases.zsh
if [ $zse -eq 1 ]; then
	## tmux-local.zsh > $HOME/.config/zsh/tmux-local.zsh
	cp files/tmux-local.zsh $usrhome/.config/zsh/tmux-local.zsh
	## tmux-ssh.zsh > $HOME/.config/zsh/tmux-ssh.zsh
	cp files/tmux-ssh.zsh $usrhome/.config/zsh/tmux-ssh.zsh
	## symlink $HOME/.tmux/tmux.conf > $HOME/.tmux.conf
	ln -s $usrhome/.tmux/.tmux.conf $usrhome/.tmux.conf
	## tmux.conf.local > $HOME/.tmux.conf.local
	cp files/tmux.conf.local $usrhome/.tmux.conf.local
	## tmux.conf.ssh > $HOME/.tmux.conf.ssh
	cp files/tmux.conf.ssh $usrhome/.tmux.conf.ssh
fi
## p10k-clean.zsh > $HOME/.config/zsh/p10kclean.zsh
cp files/p10k-clean.zsh $usrhome/.config/zsh/p10k-clean.zsh
echo "done"

# Change users shell to `ZSH`
if [ "$SHELL_TEST" != "zsh" ]; then
        if hash chsh >/dev/null 2>&1; then
                echo "Changing shell from $SHELL_TEST to zsh"
                chsh -s $(grep /zsh$ /etc/shells | tail -1)
        else
                echo "Unable to change shell using `chsh`, please change shell manually"
        fi
fi

dialog --title "ZPower Installer" --msgbox "Log out and back in to enable new settings\nor\nrun 'exec zsh'\nin your current shell" 0 0
clear
exit
