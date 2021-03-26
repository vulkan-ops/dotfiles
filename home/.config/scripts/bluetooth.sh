#!/usr/bin/env bash

iconpath="/usr/share/icons/Papirus-Dark/32x32/devices"
icon="${iconpath}/bluetooth.svg"

bluetoothctl power on
bluetoothctl agent on
bluetoothctl default-agent

function bt() {
  bluetoothctl trust ${1}
  bluetoothctl pair ${1}
  bluetoothctl connect ${1}
}

scan="Scan devices"
bt1="WS-887"


devices="$scan\n$bt1"

chosen="$(echo -e "$devices" | wofi --lines 5 --sort-order=DEFAULT --dmenu -p "  Bluetooth")"
case $chosen in
    $scan)
      bluetoothctl scan on;;
    $bt1)
      bt "69:03:AB:C5:00:4D";; # WS-887
esac
exit 0;
