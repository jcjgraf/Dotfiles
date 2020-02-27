#!/bin/bash
# Control the backlight brightness

currentLevelCache=~/.cache/backlight/level
backlightDev=/sys/class/backlight/intel_backlight/

declare -a levels=(0 1000 2000)
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

    currentLevel=$(getCurrentLevel)   

    case "$1" in
        +)
            upperBound="${#levels[@]}"
            newLevel=$(( currentLevel + 1 < upperBound ? currentLevel + 1 : currentLevel ))
            ;;
        -)
            newLevel=$(( currentLevel - 1 >= 0 ? currentLevel - 1 : 0 ))
            ;;
        *)
            newLevel=$currentLevel
            ;;
    esac
    
    echo $newLevel > $currentLevelCache
    echo ${levels[$newLevel]} > "${backlightDev}brightness"

}

usage() {
    echo "Usage: $0\n-i Increase brighness\n-d decrease brightness\n-h help"
}

while getopts 'idh' flag
do
    case "${flag}" in
        i)
            echo "$(changeLevel +)"
            ;;
        d)
            echo "$(changeLevel -)"
            ;;
        h | *)
            usage
            exit 1 ;;
    esac
done
