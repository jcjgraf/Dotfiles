#!/bin/bash

o0="Cancel"
o1="Screen"
o2="Area"
o3="Window"

options="$o0\n$o1\n$o2\n$o3"

selection="$(echo -e "$options" | displayer rofi -lines 4 -dmenu -p "Scrot" -a 0 -no-sustom)"

case $selection in
    $o1)
        cd /home/jeanclaude/Images/Scrot/ && sleep 0.5 && displayer scrot
        ;;
    $o2)
        cd /home/jeanclaude/Images/Scrot/ && sleep 0.5 && displayer scrot -s
        ;;
    $o3)
        cd /home/jeanclaude/Images/Scrot/ && sleep 0.5 && displayer scrot -u
        ;;
esac
