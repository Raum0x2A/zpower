# ZPower

## Automates installation and configuration process for #
- TMUX
- ZSH
- Oh-My-TMUX
- Oh-My-ZSH
- and other software

![](https://gitlab.com/bradley.richins/zpower/raw/master/Screenshot.png)

### Software from Ubuntu repos #
- curl
- git
- zsh
- tmux
- powerline

### Software from git #
- [Oh-My-TMUX](https://github.com/gpakosz/.tmux.git)
- [Oh-My-ZSH](https://github.com/robbyrussell/oh-my-zsh.git)
- [ZSH Auto-Suggestions](https://github.com/zsh-users/zsh-autosuggestions.git)
- [ZSH Syantax Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting.git)
- [PowerLevel 10k](https://github.com/romkatv/powerlevel10k)

### Extras #
- Aliases
  - aliases.zsh
- TMUX local session handler / remote session handler
  - tmux-local.zsh
  - tmux.conf.ssh
  - tmux-ssh.zsh
- PowerLevel10k
  - p10k-clean.zsh

### Installing #

#### clone repo #
```
$> git clone https://gitlab.com/bradley.richins/zpower.git
```

#### Open zpower directory and execute #
```
$> cd zpower
$> ./install.sh
```

or download and run the self extracting archive
```
$> chmod 755 zp-install.run
$> ./zp-install.run
```

- MakeSelf installer [GitHub Release](https://github.com/RaumXV/zpower/releases/download/v1.1/zp-install.run)
- MakeSelf installer [GitLab Release](https://gitlab.com/bradley.richins/zpower/-/raw/master/zp-install.run?inline=false)

_NOTE:_ When downloading this from gitlab the file name will most likely be changed from `zp-install.run` to `zp-install.txt`. As long as this file has exec prermissions it will work

```
$> chmod 755 zp-install.txt
$> ./zp-install.txt
```

`zp-install.run` was generated with `$> makeself --sha256 ./zpower zp-install.run "ZPower Shell Pack Installer" ./install.sh`
MakeSelf: A self-extracting archiving tool for Unix systems, in 100% shell script - [GitHub](https://github.com/megastep/makeself) / [Website](https://makeself.io/)

