#!/usr/bin/env bash

github=/home/vitor/GitHub

repo0="dotfiles"
repo1="arch"
repo2="ocean-dt"
repo3="common-tree"
repo4="vendor-ocean"
repo5="vendor-common"
repo6="kernel"
repos="$repo0\n$repo1\n$repo2\n$repo3\n$repo4\n$repo5\n$repo6"

chosen="$(echo -e "$repos" | wofi --lines 11 --dmenu -p "  Commiter")"
case $chosen in
$repo0)
alacritty -t newcommit --working-directory $HOME/.dotfiles;;
$repo1)
alacritty -t newcommit --working-directory $github/arch;;
$repo2)
alacritty -t newcommit --working-directory $github/ocean-dt;;
$repo3)
alacritty -t newcommit --working-directory $github/common-tree;;
$repo4)
alacritty -t newcommit --working-directory $github/vendor-ocean;;
$repo5)
alacritty -t newcommit --working-directory $github/vendor-common;;
$repo6)
alacritty -t newcommit --working-directory $github/kernel;;

esac
exit 0;
