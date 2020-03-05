#!/bin/bash
# Control the backlight brightness

sendNotification=false

currentLevelCache=~/.cache/backlight/level
backlightDev=/sys/class/backlight/intel_backlight/

declare -a levels=(0 50 100 200 500 1000 1500 2000 3500 5000 7500 10000 15000 20000 24242)
defaultValue=2

getCurrentLevel() {
    # Fetch the cached level and return its value. If no cache exist, create it and return the default value

    if [[ -f $currentLevelCache ]]
    then
        echo $(<$currentLevelCache)
    else
        mkdir -p "$(dirname $currentLevelCache)"
        echo "$defaultValue" > $currentLevelCache
    fi
}

changeLevel() {
    # Change the brightness level according the the provided $1. + for increase, - for decrease

    local currentLevel=$(getCurrentLevel)

    case "$1" in
        +)
            local upperBound="${#levels[@]}"
            local newLevel=$(( currentLevel + 1 < upperBound ? currentLevel + 1 : currentLevel ))
            ;;
        -)
            local newLevel=$(( currentLevel - 1 >= 0 ? currentLevel - 1 : 0 ))
            ;;
        *)
            local newLevel=$currentLevel
            ;;
    esac

    echo $newLevel > $currentLevelCache
    echo ${levels[$newLevel]} > "${backlightDev}brightness"
}

sendNotification() {
    local currentLevel=$(getCurrentLevel)
    local maxLevel="${#levels[@]}"
    local levelDiff=$((maxLevel - currentLevel - 1))

    local barLeft=$(seq -s "=" 0 $currentLevel | sed 's/[0-9]//g')
    local barRight=$(seq -s "-" 0 $levelDiff | sed 's/[0-9]//g')

    notifier -a "changeBacklight" -u low -r "1234212" "${barLeft}${barRight}"
}

usage() {
    printf "Usage: $0\n-i Increase brighness\n-d decrease brightness\n-n notification\n-h help"
}

while getopts 'idhn' flag
do
    case "${flag}" in
        i)
            changeState=+
            ;;
        d)
            changeState=-
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
