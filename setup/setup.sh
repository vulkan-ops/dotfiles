#!/usr/bin/env bash

if [[ $USER = "vulkan" ]]; then
  pwd=$(pwd) && cd $HOME
  git config --global user.email "vulkanops@gmail.com"
  git config --global user.name "vulkan-ops"
  git config --global http.postBuffer 524288000
  mkdir -p $HOME/{Images,Videos} &>/dev/null
  cd $pwd
fi

# Install YAY AUR Manager
pwd=$(pwd)
rm -rf $HOME/yay && git clone https://aur.archlinux.org/yay.git $HOME/yay && cd $HOME/yay && makepkg -si --noconfirm && rm -rf $HOME/yay
cd $pwd

# Load packages
source $HOME/.dotfiles/setup/packages.sh

# GPG Key Spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -

# Install packages
for i in "${PACKAGES[@]}"; do
  sudo pacman -Sy ${i} --needed --noconfirm
done

for i in "${AUR[@]}"; do
  yay -Sy ${i} --needed --noconfirm
done

source $HOME/.dotfiles/setup/etc.sh

chsh -s $(which zsh)
