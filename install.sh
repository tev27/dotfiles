#!/bin/bash
# run from project root (dotfiles/)

mkdir -p ~/.config

# link config dirs
ln -s $(realpath ./mangowm) $(realpath ~/.config/mango)
