# Path to your Oh My Zsh installation.
export ZSH="/usr/share/oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source /usr/share/zinit/zinit.zsh

# zinit configuration

zinit wait lucid for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    marlonrichert/zsh-autocomplete \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

source $ZSH/oh-my-zsh.sh

eval "$(zoxide init --cmd cd zsh)"
export EDITOR='vim'
