#!/bin/bash

# Rotate built-in screen including touch/pen

declare -a devices=("Wacom Pen and multitouch sensor Finger touch" "Wacom Pen and multitouch sensor Pen stylus" "Wacom Pen and multitouch sensor Pen eraser")

rotate() {
    xrandr -o $1
    
    for i in "${devices[@]}"
    do
        xsetwacom set "$i" Rotate $2
    done
}

if [[ $# -eq 0 ]]
then
    rotate 0 none
fi

while getopts 'hnlr' flag
do
    case "${flag}" in
        n)
            rotate 0 none       
            ;; 
        l)
            rotate 3 cw       
            ;; 
        r)
            rotate 1 ccw       
            ;; 
        h | *)
            echo "Usage: $0 -h -n -l -r" 1>&2; exit 1;
            ;;     
    esac
done
