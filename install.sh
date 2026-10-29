#!/bin/bash
# run from project root (dotfiles/)

source ./install-base.sh
mkdir -p ~/.config
mkdir -p ~/Pictures/Screenshots

# link config dirs
ln -s $(realpath ./mangowm) $(realpath ~/.config/mango)
ln -s $(realpath ./mako) $(realpath ~/.config/mako)

# other config repos
echo "See also:"
echo "https://github.com/gpakosz/.tmux"

