#!/bin/bash

# Map the pen device explicitly to the touch screen

declare -a devices=("Wacom Pen and multitouch sensor Finger touch" "Wacom Pen and multitouch sensor Pen stylus" "Wacom Pen and multitouch sensor Pen eraser")

for i in "${devices[@]}"
do
    id=$( xinput --list --id-only "$i" )
    xinput map-to-output "$id" eDP-1
done
