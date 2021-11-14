#!/bin/bash
# Control the volume
# Might require setting the default sink using
# pactl set-default-sink <someSink>

APPNAME=$( basename "$0" | sed "s/\.sh$//" )

notification="false"
sink="@DEFAULT_SINK@"
maxVolumeLevel=120

verbose="false"

v_log_debug() {
    if $verbose
    then
        echo "$APPNAME: DEBUG: $1" > /dev/tty
    fi
}

v_run_pactl() {
    out=$(sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl $1)
    echo $out
}

v_change_level() {
    # Change the volume according the the provided $1. + for increase, - for decrease
    case "$1" in
        +)
            #sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl set-sink-volume "$sink" +5%
            v_run_pactl "set-sink-volume $sink +5%"
            ;;
        -)
            #sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl set-sink-volume "$sink" -5%
            v_run_pactl "set-sink-volume $sink -5%"
            ;;
        m)
            #sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl set-sink-mute "$sink" toggle
            v_run_pactl "set-sink-mute $sink toggle"
            ;;
        *)
            ;;
    esac

}

v_send_notification() {
    local mute=$(v_run_pactl "get-sink-mute $sink" | sed -e 's_.*: \(\w\)_\1_')

    local level=$(v_run_pactl "get-sink-volume $sink" | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')


    v_log_debug "Current Level: $level"

    level=$(( level * 100 ))
    level=$(( level / $maxVolumeLevel ))

    v_log_debug "Normalized Level: $level"
    
    local levelDiff=$((20 - level))

    if [[ $mute == no ]]
    then
        local message="  Unmute"
    else
        local message=" Mute"
    fi

    displayer dunstify -a "changeVolume" -u low -r "38462528" -h int:value:$level $message
}

v_usage() {
    printf "Usage: $0\n-i Increase volume\n-d decrease volumei\n-m mute\n-n notification\n-h help"
}

while (( $# ))
do
    case "$1" in
        -i)
            changeState=+
            shift
            ;;
        -d)
            changeState=-
            shift
            ;;
        -m)
            changeState=m
            shift
            ;;
        -n)
            notification="true"
            shift
            ;;
        -v)
            verbose="true"
            shift
            ;;
        -h | *)
            v_usage
            exit 1 ;;
    esac
done

if [[ -n ${changeState+x} ]]
then
    echo "$(v_change_level $changeState)"
fi

if $notification
then
    v_log_debug "Send Notification"
    $(v_send_notification)
fi
