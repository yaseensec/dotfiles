#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vim='nvim'
export PATH=$PATH:~/Documents/scripts/
PS1='[\u@\h \W]\$ '
