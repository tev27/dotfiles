#!/bin/bash
# run from project root (dotfiles/)

source ./install-base.sh
mkdir -p ~/.config
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-4.0

# link config dirs
echo "linking config dirs"
ln -s $(realpath ./mangowm) $(realpath ~/.config/mango)
ln -s $(realpath ./mako) $(realpath ~/.config/mako)
ln -s $(realpath ./kitty) $(realpath ~/.config/kitty)
ln -s $(realpath ./xdg-desktop-portal-termfilechooser) $(realpath ~/.config/xdg-desktop-portal-termfilechooser)
ln -s $(realpath ./xdg-desktop-portal) $(realpath ~/.config/xdg-desktop-portal)

if [[ $DARKMODE -eq 1 ]]; then
  ln -s $(realpath ./gtk-3.0/settings.ini) $(realpath ~/.config/gtk-3.0/settings.ini)
  ln -s $(realpath ./gtk-4.0/settings.ini) $(realpath ~/.config/gtk-4.0/settings.ini)
fi

if [[ -e ~/.zshrc ]]; then
  echo "moved pre-existing zshrc to ~/.zshrc.bak"
  mv ~/.zshrc ~/.zshrc.bak
fi

ln -s $(realpath ./zshrc) $(realpath ~/.zshrc)

if [[ -e /usr/share/zsh/plugins/zsh-autcomplete ]]; then
  echo "linking zsh plugins to oh-my-zsh plugins"
  sudo ln -s $(realpath /usr/share/zsh/plugins/zsh-autocomplete) $(realpath /usr/share/oh-my-zsh/custom/plugins/zsh-autocomplete)
fi

# other config repos
echo "See also:"
echo "https://github.com/gpakosz/.tmux"

echo "\n And:"
echo "- ensure pacman mirrorlist is up to date"
echo "- change default shell to zsh"
echo "- install luks-automount.sh to /usr/bin and add udev rules for luks usbs"
