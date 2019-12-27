#!/bin/sh

# Prepare background
imgPath="/tmp/bg_img.png"

resolution=$(xrandr | grep \* | cut -d' ' -f4)
ffmpeg -f x11grab -video_size "$resolution" -y -i "$DISPLAY" -filter_complex "boxblur=5:5" -vframes 1 "$imgPath" -loglevel quiet

# Screen setting and lock
set -e
xset s off dpms 0 3 0
i3lock --ignore-empty-password --nofork --image "$imgPath"
xset s off -dpms
