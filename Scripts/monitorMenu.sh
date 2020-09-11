#!/bin/bash

o0="Cancel"
o1="Only eDP-1"
o2="Only HDMI-1"
o3="Dual Screen eDP-1 -> HDMI-1"
o4="Clone Screen eDP-1 -> HDMI-1"

options="$o0\n$o1\n$o2\n$o3\n$o4"

selection="$(echo -e "$options" | displayer rofi -lines 5 -dmenu -p "Monitor" -a 0 -no-sustom)"
echo $selection

case $selection in
    $o1)
        /home/jeanclaude/bin/monitor.sh -s
        ;;
    $o2)
        /home/jeanclaude/bin/monitor.sh -e
        ;;
    $o3)
        /home/jeanclaude/bin/monitor.sh -m
        ;;
    $o4)
        /home/jeanclaude/bin/monitor.sh -m
        ;;
esac
