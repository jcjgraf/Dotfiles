#!/bin/sh

isAutoDim=false
addImage=false
isNoFork=false

args="--ignore-empty-password"

usage() {
    printf "Usage: $0\n-i add image\n-d enable auto dim\n-f enable no fork\n-h help"
}

while getopts 'idfh' flag
do
    case "${flag}" in
        i)
            addImage=true
            ;;
        d)
            isAutoDim=true
            ;;
        f)
           isNoFork=true 
            ;;
        h | *)
            usage
            exit 1 ;;
    esac
done

# Add background image or color
if [[ $addImage = true ]]
then
    imgPath="/tmp/bg_img.png"

    scrot --multidisp --quality 50 --overwrite --silent "$imgPath"

    # Pixelate Image
    #convert -scale 10% -scale 1000% "$imgPath" "$imgPath"

    # Blure Image
    ffmpeg -y -i "$imgPath" -filter_complex "boxblur=5:5" -loglevel quiet "${imgPath}_out.png" && mv "${imgPath}_out.png" "$imgPath"

    args="${args} --tiling --image \"$imgPath\""
else
    color="$( xrdb -query | grep background: | awk '{print $NF}' )"
    args="${args} --color $color"
fi

# Dim screen when locked
if [[ $isAutoDim = true ]]
then
    set -e
    xset s off dpms 0 3 0
fi

# Add nofork option 
if [[ $isNoFork = true ]]
then
    args="${args} --nofork"
fi

i3lock $args

# Undim screen

if [[ $isAutoDim = true ]]
then
    xset s off -dpms
fi
