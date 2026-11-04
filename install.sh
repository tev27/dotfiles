#!/bin/bash
# run from project root (dotfiles/)

source ./install-base.sh
mkdir -p ~/.config
mkdir -p ~/Pictures/Screenshots

# link config dirs
echo "linking config dirs"
ln -s $(realpath ./mangowm) $(realpath ~/.config/mango)
ln -s $(realpath ./mako) $(realpath ~/.config/mako)
ln -s $(realpath ./kitty) $(realpath ~/.config/kitty)
ln -s $(realpath ./xdg-desktop-portal-termfilechooser) $(realpath ~/.config/xdg-desktop-portal-termfilechooser)
ln -s $(realpath ./xdg-desktop-portal) $(realpath ~/.config/xdg-desktop-portal)

# other config repos
echo "See also:"
echo "https://github.com/gpakosz/.tmux"

echo "\n And:"
echo "- ensure pacman mirrorlist is up to date"
echo "- change default shell to zsh"
