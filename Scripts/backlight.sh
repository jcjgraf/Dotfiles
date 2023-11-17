#!/bin/bash
# Control the backlight brightness

APPNAME=$( basename "$0" | sed "s/\.sh$//" )

notification="false"

currentLevelCache=/tmp/backlight/level
backlightDev=/sys/class/backlight/intel_backlight

declare -a levels=(0 1 2 3 5 10 15 20 25 50 75 100 125 150 175 200 225 250 300 325 350 375 400)

defaultValue=2
calibrateLevel=100

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
    # Change the brightness level according to the provided $1. + for increase, - for decrease

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

    local message=""

    if [ "${levels[$level]}" -eq "$calibrateLevel" ]; then
        local message=""
    fi

    local level=$(( level * 100 ))
    local level=$(( level / maxLevel ))

    b_log_debug "Normalized Level $level"

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
