#!/bin/bash
# meant to be run on a base arch install with pacman and internet access

GITREPO=https://github.com/tev27/dotfiles.git
DOTFILESDIR=~/dotfiles
AURDIR=~/AUR
PACKAGES=(
	# necessary for pulling dotfiles
	git
	# utils
	less linux linux-firmware base-devel tree htop
	pipewire-jack noto-fonts brightnessctl playerctl
	# environment
	mangowm tmux firefox rofi kitty
	)

AURPACKAGES=(xfce-polkit)

echo "hello dotfiles!"
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm "${PACKAGES[@]}"

mkdir -p AURDIR
for aurname in $AURPACKAGES
do
	git clone "https://aur.archlinux.org/$aurname.git" $AURDIR/$aurname
	makepkg -siD $AURDIR/$aurname --noconfirm
done


git clone --depth=1 $GITREPO $DOTFILESDIR

cd $DOTFILESDIR
source install.sh
