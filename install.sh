#!/bin/bash
# run from project root (dotfiles/)

# link config dirs
ln -s $(realpath ./mangowm) $(realpath ~/.config/mango)
