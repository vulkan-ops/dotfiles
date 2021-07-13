#!/usr/bin/env bash

source $HOME/.colors &>/dev/null

function f() {
  git fetch https://github.com/${1} ${2}
}

function p() {
  git cherry-pick ${1}
}

function cc() {
  git add . && git cherry-pick --continue
}

function a() {
  git cherry-pick --abort
}

function translate() {
  typing=$(mktemp)
  rm -rf $typing && nano $typing
  msg=$(trans -b :en -no-auto -i $typing)
  cat $typing
}

if [ $HOST = "vitor" ]; then
  function cm() {
    translate
    git add . && git commit --message $msg --signoff --author "vulkan-ops <vulkanops@gmail.com>" && git push -f
  }
  function c() {
    git add . && git commit --author "${1}" && git push -f
  }
  function amend() {
    git add . && git commit --signoff --amend && git push -f
  }
else
  function cm() {
    translate
    git add . && git commit --message $msg --signoff --author "vulkan-ops <vulkanops@gmail.com>" && git push -f
  }
  function c() {
    git add . && git commit --author "${1}"
  }
  function amend() {
    git add . && git commit --amend
  }
fi

function upd() {
  $HOME/.config/scripts/pacman-update.sh
}

function sshgen() {
  ssh-keygen -t ed25519 -C "vulkanops@gmail.com"
  eval "$(ssh-agent -s)" && ssh-add -l
  cat $HOME/.ssh/id_ed25519.pub | wl-copy
  xdg-open https://github.com/settings/ssh/new
}

function wifi() {
  interface=$(cat /proc/net/wireless | perl -ne '/(\w+):/ && print $1')
  iwctl station $interface scan && sleep 3
  iwctl station $interface get-networks
  echo "${BLU}Which network do you want to connect to?${END} "; read wifi
  iwctl station $interface connect "${wifi}"
}

function fetch() {
  ./.dotfiles/home/.config/scripts/fetch.sh gnu
}

function vm () {
ssh vitor@casa.luizdores.com.br
}

function job () {
cd Downloads
mkdir github
cd github
git clone https://github.com/vulkan-ops/myarch myarch
git clone https://github.com/vulkan-ops/device_motorola_ocean ocean-dt
git clone https://github.com/vulkan-ops/device_motorola_channel	channel-dt
git clone https://github.com/vulkan-ops/device_motorola_river	river-dt
git clone https://github.com/vulkan-ops/device_motorola_sdm632-common  common-tree
git clone https://github.com/vulkan-ops/vendor_motorola_ocean  vendor-ocean
git clone https://github.com/vulkan-ops/vendor_motorola_river	vendor-river
git clone https://github.com/vulkan-ops/vendor_motorola_channel	vendor-channel
git clone https://github.com/vulkan-ops/vendor_motorola_sdm632-common vendor-common
git clone https://github.com/vulkan-ops/kernel_motorola_sdm632 kernel
}

function v () {
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
export CCACHE_DIR=$HOME/.ccache
ccache -M 50G
. build/envsetup.sh
lunch aosp_${1}-userdebug
make bacon -j$(nproc --all) | tee ${1}.log
}

