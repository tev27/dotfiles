#!/bin/bash
# meant to be run on a base arch install with pacman and internet access

GITREPO=https://github.com/tev27/dotfiles.git
DOTFILESDIR=dotfiles
AURDIR=AUR
PACKAGES=(
	# necessary for pulling dotfiles
	git
	# utils
	less linux linux-firmware base-devel tree htop mlocate
	pipewire-jack noto-fonts brightnessctl playerctl
	xdg-desktop-portal-wlr zoxide
	# DE utils
	wev grim slurp wl-clipboard cliphist wl-clip-persist
	# environment
	mangowm tmux firefox rofi kitty mako
	)

AURPACKAGES=(xfce-polkit)

echo "updating and installing packages..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm "${PACKAGES[@]}"

echo "installing AUR packages..."
cd
mkdir -p $AURDIR
for aurname in ${AURPACKAGES[@]}
do
	git clone "https://aur.archlinux.org/$aurname.git" $AURDIR/$aurname
	makepkg -sicD $AURDIR/$aurname --noconfirm
done

# clear orphans created by aur make
echo "clearing orphaned packages install by makepkg"
sudo pacman -Qdtq | sudo pacman -Rns --noconfirm -


echo "adding zoxide to .zshrc"
echo "eval "$(zoxide init zsh)" >> ~/.zshrc


git clone --depth=1 $GITREPO $DOTFILESDIR

cd $DOTFILESDIR
source install.sh
