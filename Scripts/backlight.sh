#!/bin/bash
# Control the backlight brightness

APPNAME=$( basename "$0" | sed "s/\.sh$//" )

notification="false"

currentLevelCache=$XDG_CACHE_HOME/backlight/level
backlightDev=/sys/class/backlight/intel_backlight

declare -a levels=(0 50 100 200 500 1000 1500 2000 3500 5000 7500 10000 15000 20000 24242)
defaultValue=2

verbose="false"

b_log_debug() {
    if $verbose
    then
        echo "$APPNAME: DEBUG: $1" > /dev/tty
    fi
}

b_get_current_level() {
    # Fetch the cached level and return its value. If no cache exist, create it and return the default value

    if [[ ! -f $currentLevelCache ]]
    then
        b_log_debug "Create Cache File"
        mkdir -p "$(dirname $currentLevelCache)"
        echo "$defaultValue" > $currentLevelCache
    fi

    echo $(<$currentLevelCache)
}

b_change_level() {
    # Change the brightness level according the the provided $1. + for increase, - for decrease

    local currentLevel=$(b_get_current_level)

    case "$1" in
        +)
            local upperBound=${#levels[@]}
            local upperBound=$(( upperBound - 1 ))
            local newLevel=$(( currentLevel + 1 <= upperBound ? currentLevel + 1 : currentLevel ))
            ;;
        -)
            local newLevel=$(( currentLevel - 1 >= 0 ? currentLevel - 1 : 0 ))
            ;;
        *)
            local newLevel=$currentLevel
            ;;
    esac

    echo $newLevel > $currentLevelCache
    echo ${levels[$newLevel]} > "${backlightDev}/brightness"
}

b_send_notification() {
    local level=$(b_get_current_level)
    local maxLevel=${#levels[@]}
    local maxLevel=$(( maxLevel - 1 ))

    b_log_debug "Current Level $level"

    local level=$(( level * 100 ))
    local level=$(( level / maxLevel ))

    b_log_debug "Normalized Level $level"

    local message=""

    displayer dunstify -a "changeBacklight" -u low -r "1234212" -h int:value:$level $message
}

b_usage() {
    printf "Usage: $0\n-i Increase brighness\n-d decrease brightness\n-n notification\n-h help"
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
        -n)
            notification="true"
            shift
            ;;
        -v)
            verbose="true"
            shift
            ;;
        -h | *)
            b_usage
            exit 1 ;;
    esac
done

if [[ -n ${changeState+x} ]]
then
    echo "$(b_change_level $changeState)"
fi

if [[ $notification = true ]]
then
    $(b_send_notification)
fi
