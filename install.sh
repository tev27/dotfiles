#!/bin/bash
# run from project root (dotfiles/)

mkdir -p ~/.config
mkdir -p ~/Pictures/Screenshots

# link config dirs
ln -s $(realpath ./mangowm) $(realpath ~/.config/mango)
