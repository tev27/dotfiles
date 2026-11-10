# Path to your Oh My Zsh installation.
export ZSH="/usr/share/oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source /usr/share/zinit/zinit.zsh

# zinit configuration

eval "$(zoxide init --cmd cd zsh)"
export EDITOR='vim'

zi for \
  atload"zicompinit; zicdreplay" \
  blockf \
  lucid \
  load \
  @marlonrichert/zsh-autocomplete \
  load \
  @zsh-users/zsh-autosuggestions


source $ZSH/oh-my-zsh.sh

