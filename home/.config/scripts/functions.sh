#!/usr/bin/env bash

source $HOME/.colors &>/dev/null

aetc() {
	#sudo cp /home/vulkan/.dotfiles/home/capivara/etc/hosts /etc/hosts
	#sudo cp /home/vulkan/.dotfiles/home/capivara/etc/ntp.conf /etc/ntp.conf
	#sudo ntpd -q -g  && sudo hwclock --systohc
 	sudo fastboot oem fb_mode_set
 	sudo fastboot flash partition gpt.bin
 	sudo fastboot flash bootloader bootloader.img
 	sudo fastboot flash vbmeta vbmeta.img
 	sudo fastboot flash vbmeta_system vbmeta_system.img
 	sudo fastboot flash modem NON-HLOS.bin
 	sudo fastboot erase mdmddr
 	sudo fastboot flash fsg fsg.mbn
 	sudo fastboot erase mdm1m9kefs1
 	sudo fastboot erase mdm1m9kefs2
 	sudo fastboot flash bluetooth BTFM.bin
 	sudo fastboot flash dsp dspso.bin
 	sudo fastboot flash logo logo.bin
 	sudo fastboot flash boot boot.img
 	sudo fastboot flash vendor_boot vendor_boot.img
 	sudo fastboot flash dtbo dtbo.img
	sudo fastboot flash super super.img_sparsechunk.0
 	sudo fastboot flash super super.img_sparsechunk.1
 	sudo fastboot flash super super.img_sparsechunk.2
 	sudo fastboot flash super super.img_sparsechunk.3
 	sudo fastboot flash super super.img_sparsechunk.4
 	sudo fastboot flash super super.img_sparsechunk.5
 	sudo fastboot flash super super.img_sparsechunk.6
	sudo fastboot flash super super.img_sparsechunk.7
 	sudo fastboot flash super super.img_sparsechunk.8
 	sudo fastboot flash super super.img_sparsechunk.9
 	sudo fastboot flash super super.img_sparsechunk.10
 	sudo fastboot flash super super.img_sparsechunk.11
 	sudo fastboot flash super super.img_sparsechunk.12
	sudo fastboot erase carrier
 	sudo fastboot erase ddr
 	sudo fastboot oem fb_mode_clear
 	sudo fastboot -w
}

f() {
  git fetch https://github.com/${1} ${2}
}

p() {
  git cherry-pick ${1}
}

cc() {
  git add . && git cherry-pick --continue
}

a() {
  git cherry-pick --abort
}

function translate() {
  typing=$(mktemp)
  rm -rf $typing && nano $typing
  msg=$(trans -b :en -no-auto -i $typing)
  cat $typing
}

if [ $HOST = "vulkan" ]; then
  cm() {
    translate
    git add . && git commit --message $msg --signoff --author "vulkan-ops <vulkanops@gmail.com>" && git push -f
  }
  c() {
    git add . && git commit --author "${1}" && git push -f
  }
  amend() {
    git add . && git commit --signoff --amend && git push -f
  }
else
  cm() {
    translate
    git add . && git commit --message $msg --signoff --author "vulkan-ops <vulkanops@gmail.com>" && git push -f
  }
  c() {
    git add . && git commit --author "${1}"
  }
  amend() {
    git add . && git commit --amend
  }
fi

upd() {
  $HOME/.config/scripts/pacman-update.sh
}

sshgen() {
  ssh-keygen -t ed25519 -C "vulkanops@gmail.com"
  eval "$(ssh-agent -s)" && ssh-add -l
  cat $HOME/.ssh/id_ed25519.pub | wl-copy
  xdg-open https://github.com/settings/ssh/new
}

# play audio based search
yplay() {
    mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
}

# play video based on the clipboard
play() {
        mpv "$(wl-paste 2>/dev/null || xclip -o 2>/dev/null)"
}

# download files based on the clipboard
down() {
    aria2c "$(wl-paste 2>/dev/null || xclip -o 2>/dev/null)"
}

pkginf() {
    clear && pacman -Si $@ | awk '/Name/{print "Package: " $3}/Version/{print "Version: " $3}/Installed Size/{printf "Size: %s %s\n", $4, $5}'
}

pkginf1() {
   clear && pacman -Q $@
}

usage() {
    for p in "$@" ; do
        if pidof $p >/dev/null ; then
            RAM=$(echo $(ps -A --sort -rsz -o comm,rss | grep $p | sed -n 1p | sed 's/.* //g') / 1000 | bc)
            PRAM=$(ps -A --sort -rsz -o comm,pmem | grep $p | sed -n 1p | sed 's/.* //g')
            PCPU=$(ps -A --sort -rsz -o comm,pcpu | grep $p | sed -n 1p | sed 's/.* //g')
            echo "$p está usando ${RAM}mb de RAM (${PRAM}%) e ${PCPU}% de CPU"
        else
            echo "$p não está rodando."
        fi
    done
}
wifi() {
  interface=$(cat /proc/net/wireless | perl -ne '/(\w+):/ && print $1')
  iwctl station $interface scan && sleep 3
  iwctl station $interface get-networks
  echo "${BLU}Which network do you want to connect to?${END} "; read wifi
  iwctl station $interface connect "${wifi}"
}

vm () {
sudo systemctl enable --now tailscaled
sudo tailscale up
ssh vulkan@100.90.167.139
}

job () {
cd Downloads
mkdir pstar_devops
cd pstar_devops
git clone ssh://git@github.com/vulkan-ops/device_motorola_pstar pstar-dt
git clone https://gitlab.com/vulkan-ops/vendor_motorola_pstar   pstar-vendor
git clone ssh://git@github.com/vulkan-ops/kernel_motorola_sm8250   kernel-sm8250
}
