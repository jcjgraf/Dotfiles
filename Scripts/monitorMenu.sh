#!/bin/bash

o0="Cancel"
o1="Internal Only"
o2="External Only"
o3="Extend Internal"
o4="Clone Internal"

options="$o0\n$o1\n$o2\n$o3\n$o4"

selection="$(echo -e "$options" | displayer rofi -lines 5 -dmenu -p "Monitor" -a 0 -no-sustom)"
echo $selection

case $selection in
    $o1)
        displayer /home/jeanclaude/bin/monitor.sh --internal
        ;;
    $o2)
        displayer /home/jeanclaude/bin/monitor.sh --external
        ;;
    $o3)
        displayer /home/jeanclaude/bin/monitor.sh --extend
        ;;
    $o4)
        displayer /home/jeanclaude/bin/monitor.sh --clone
        ;;
esac
