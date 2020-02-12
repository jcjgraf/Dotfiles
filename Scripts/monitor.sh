#!/bin/bash
# Monitor controller

usage() {
    echo "Usage: $0 -h -s -m" 1>&2; exit 1;
}

# No flags passed
if [[ $# -eq 0 ]]
then
   usage
fi

# Flags passed
while getopts 'hsm' flag
do
    case "${flag}" in
        s)
            # Single monitor
            xrandr --output eDP-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off
            ;;
        m)
            # Multiple monitor
            xrandr --output eDP-1 --primary --mode 3840x2160 --pos 432x2700 --rotate normal --output DP-1 --off --output HDMI-1 --mode 1920x1080 --scale 2.5x2.5 --pos 0x0 --rotate normal --output DP-2 --off
            ;;
        h | *)
            usage
            ;;
    esac
done
