#!/bin/bash
# Control the volume

sendNotification=false

changeLevel() {
    # Change the volume according the the provided $1. + for increase, - for decrease

    case "$1" in
        +)
            sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl set-sink-volume @DEFAULT_SINK@ +5%
            ;;
        -)
            sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl set-sink-volume @DEFAULT_SINK@ -5%
            ;;
        m)
            sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl set-sink-mute @DEFAULT_SINK@ toggle 
            ;;
        *)
            ;;
    esac
    
}

sendNotification() {
    local mute=$(sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl list sinks | grep '^[[:space:]]Mute:' | sed -e 's_.*: \(\w\)_\1_')
    local currentLevel=$(sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
    currentLevel=$((currentLevel / 10 + 1))

    local levelDiff=$((20 - currentLevel))
    
    if [[ $mute == no ]]
    then
        local barLeft=$(seq -s "=" 0 $currentLevel | sed 's/[0-9]//g')
    else
        local barLeft=$(seq -s "x" 0 $currentLevel | sed 's/[0-9]//g')
    fi
    local barRight=$(seq -s "-" 0 $levelDiff | sed 's/[0-9]//g')

    notifier -a "changeVolume" -u low -r "38462528" " ${barLeft}${barRight}"
}

usage() {
    printf "Usage: $0\n-i Increase volume\n-d decrease volumei\n-m mute\n-n notification\n-h help"
}

while getopts 'idhnm' flag
do
    case "${flag}" in
        i)
            changeState=+
            ;;
        d)
            changeState=-
            ;;
        m)
            changeState=m
            ;;
        n)
            sendNotification=true
            ;;
        h | *)
            usage
            exit 1 ;;
    esac
done

if [[ -n ${changeState+x} ]]
then
    echo "$(changeLevel $changeState)"
fi

if [[ $sendNotification = true ]]
then
    $(sendNotification)
fi
