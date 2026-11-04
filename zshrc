# Path to your Oh My Zsh installation.
export ZSH="/usr/share/oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"
alias cd=z
export EDITOR='vim'
