# Lines configured by zsh-newuser-install

# Enable colors and change prompt:

autoload -U colors && colors

# History in cache directory:

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=5000
bindkey -e

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/im/.zshrc'

# Basic auto/tab complete:

autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# End of lines added by compinstall

#Auto Complete With Case Sensitivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# Suggest aliases for commands
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh 2>/dev/null
#Prompt
source ~/agnoster.zsh-theme
setopt prompt_subst

##Aliases

alias vi="nvim"
alias vim="nvim"
#alias fdm="/opt/freedownloadmanager/fdm"
alias iplbd="sudo ip link set br0 down"
alias iplbu="sudo ip link set br0 up"
alias dotfiles="/usr/bin/git --git-dir=$HOME/Git/Github/dotfiles/ --work-tree=$HOME"
alias py="python"
alias reflector="sudo reflector --latest 50 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias wildfly="/opt/wildfly/bin/standalone.sh"
alias blue="sudo systemctl start bluetooth.service"
alias p="paru -Sc --noconfirm && paru -Syu --noconfirm"
alias d="sudo du -ach --max-depth=1"
alias s="sudo swapon /swapfile"
alias so="sudo swapoff -v /swapfile"
alias ssh-enigma="ssh yaseen@192.168.122.111"
alias ssh-node2="ssh yaseen@192.168.122.77"
alias ssh-rhel="ssh root@192.168.122.31"
alias ssh-tx="ssh u0_a214@192.168.0.3 -p 8022"
alias std="sudo systemctl start docker"
alias spd="sudo systemctl stop docker"
alias rtd="sudo systemctl restart docker"
alias ssd="sudo systemctl status docker"
alias yv="yt-dlp --config-location '~/.config/youtube-dl/config-video'"
alias ym="yt-dlp --config-location '~/.config/youtube-dl/config-audio'"

# Changing "ls" to "exa"
alias ls='exa -g --color=always --group-directories-first' # my preferred listing
alias la='exa -ag --color=always --group-directories-first'  # all files and dirs
alias ll='exa -lHg --color=always --group-directories-first'  # long format
alias lt='exa -aTg --color=always --group-directories-first' # tree listing

#Pywal and Less
#(cat ~/.cache/wal/sequences &)

#source ~/.cache/wal/colors-tty.sh

unset LESS;
export TERM=xterm-256color
export GIT_EDITOR=nvim

path+=('~/.local/bin/')

#fnm
#eval "$(fnm env)"

# Dynamic window title with zsh shell.
# Shows current directory and running (multi-line) command.
case "$TERM" in (rxvt|rxvt-*|st|st-*|*xterm*|(dt|k|E)term)
    local term_title () { print -n "\e]0;${(j: :q)@}\a" }
    precmd () {
      local DIR="$(print -P '%2c:')"
      term_title "$DIR" "zsh"
    }
    preexec () {
      local DIR="$(print -P '%c:')"
      local CMD="${(j:\n:)${(f)1}}"
      term_title "$DIR" "$CMD"
    }
  ;;
esac

if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi
