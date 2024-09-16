#!/bin/sh
export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.histfile
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP


# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

#Auto Complete With Case Sensitivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#source ~/.config/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh 2>/dev/null



# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "MichaelAquilina/zsh-you-should-use"
zsh_add_plugin "hlissner/zsh-autopair"
#zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

# Key-bindings
bindkey -s '^o' 'ranger^M'
bindkey -s '^f' 'zi^M'
bindkey -s '^s' 'ncdu^M'
# bindkey -s '^n' 'nvim $(fzf)^M'
# bindkey -s '^v' 'nvim\n'
bindkey -s '^z' 'zi^M'
bindkey '^[[P' delete-char
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
bindkey -r "^u"
bindkey -r "^d"

# FZF 
# TODO update for mac
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#[ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"
# export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
compinit

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line

## Speedy keys
xset r rate 210 40

## Environment variables set everywhere
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export TERM="xterm-256color"
export GIT_EDITOR="nvim"


## Dynamic window title with zsh shell.
## Shows current directory and running (multi-line) command.
case "$TERM" in (alacritty|rxvt|rxvt-*|st|st-*|*xterm*|(dt|k|E)term)
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

## Ranger
if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi

# For QT Themes
#export QT_QPA_PLATFORMTHEME=qt5ct

# remap caps to escape
#setxkbmap -option caps:escape
# swap escape and caps
# setxkbmap -option caps:swapescape

## Auto Completion Terraform and AWS-CLI
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

complete -C aws_completer aws


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
#[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
#export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1



