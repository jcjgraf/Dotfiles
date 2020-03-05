#!/bin/sh

# Prepare background
imgPath="/tmp/bg_img.png"

# Take Screenshot
#scrot --multidisp --quality 50 --overwrite --silent "$imgPath"

# Pixelate Image
#convert -scale 10% -scale 1000% "$imgPath" "$imgPath"

# Blure Image
#ffmpeg -y -i "$imgPath" -filter_complex "boxblur=5:5" -loglevel quiet "${imgPath}_out.png" && mv "${imgPath}_out.png" "$imgPath"

# Screen setting and lock
set -e
xset s off dpms 0 3 0
#i3lock --ignore-empty-password --nofork --tiling --image "$imgPath"
color="$( xrdb -query | grep background: | awk '{print $NF}' )"
i3lock --ignore-empty-password --nofork --color $color 
xset s off -dpms
