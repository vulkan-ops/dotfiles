[ -z "$PS1" ] && return
export OUT_DIR=/mnt/hd3/vitor/out
HISTCONTROL=ignoreboth
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

NONE="\[\033[0m\]"
K="\[\033[0;30m\]"
R="\[\033[0;31m\]"
G="\[\033[0;32m\]"
Y="\[\033[0;33m\]"
B="\[\033[0;34m\]"
M="\[\033[0;35m\]"
C="\[\033[0;36m\]"
W="\[\033[0;37m\]"
BK="\[\033[1;30m\]"
BR="\[\033[1;31m\]"
BG="\[\033[1;32m\]"
BY="\[\033[1;33m\]"
BB="\[\033[1;34m\]"
BM="\[\033[1;35m\]"
BC="\[\033[1;36m\]"
BW="\[\033[1;37m\]"
BGK="\[\033[40m\]"
BGR="\[\033[41m\]"
BGG="\[\033[42m\]"
BGY="\[\033[43m\]"
BGB="\[\033[44m\]"
BGM="\[\033[45m\]"
BGC="\[\033[46m\]"
BGW="\[\033[47m\]"

if [ $UID -eq "0" ]; then

PS1="$G┌─[$BR\u$G]$BY@$G[$BW${HOSTNAME%%.*}$G]$B:\w\n$G└──>$BR \\$ $NONE"

else

PS1="$BR┌─[$BG\u$BR]$BY@$BR[$BW${HOSTNAME%%.*}$BR]$B:\w\n$BR└──>$BG \\$ $NONE"

fi

# PS1="\e[01;31m┌─[\e[01;35m\u\e[01;31m]──[\e[00;37m${HOSTNAME%%.*}\e[01;32m]:\w$\e[01;31m\n\e[01;31m└──\e[01;36m>>\e[00m"
# PS1='\[\e[m\n\e[1;30m\][$:$PPID \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \d \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n($SHLVL:\!)\$ '}
# PS1="\e[01;31m┌─[\e[01;35m\u\e[01;31m]──[\e[00;37m${HOSTNAME%%.*}\e[01;32m]:\w$\e[01;31m\n\e[01;31m└──\e[01;36m>>\e[00m"
# PS1="┌─[\[\e[34m\]\h\[\e[0m\]][\[\e[32m\]\w\[\e[0m\]]\n└─╼ "
# PS1='[\u@\h \W]\$ '

if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
fi

alias list='sudo nano /etc/apt/sources.list'
alias upd='sudo apt-get update && sudo apt-get upgrade'
alias aptrep='sudo apt-get -f install'
alias dpkgrep='sudo dpkg --configure -a'
alias google='ping -t 3 www.google.com.br'
alias uol='ping -t 3 www.uol.com.br'
export HISTTIMEFORMAT="%d/%m/%y %T "


function dt () {
git clone https://github.com/vulkan-ops/device_motorola_ocean -b statixOS device/motorola/ocean
git clone https://github.com/vulkan-ops/device_motorola_sdm632-common -b statixOS device/motorola/sdm632-common
git clone https://gitlab.com/vulkan-ops/vendor_motorola_ocean  vendor/motorola/ocean
git clone https://gitlab.com/vulkan-ops/vendor_motorola_sdm632-common  vendor/motorola/sdm632-common
git clone https://github.com/vulkan-ops/kernel_motorola_sdm632  kernel/motorola/sdm632
}

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

function c() {
    git add . && git commit --author "${1}" && git push -f
  }
    function amend() {
    git add . && git commit --amend
  }

function b () {
. build/envsetup.sh
brunch statix_${1}-userdebug | tee ${1}.log
}
