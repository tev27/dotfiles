# Path to your Oh My Zsh installation.
export ZSH="/usr/share/oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source /usr/share/zinit/zinit.zsh

# zinit configuration

zinit wait lucid for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

zinit wait lucid for \
  marlonrichert/zsh-autocomplete

source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"
alias cd=z
export EDITOR='vim'
