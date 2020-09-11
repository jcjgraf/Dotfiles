#!/bin/bash

# Icons
chargingIcon=""
batteryFull=""
batteryThreeQuaters=""
batteryHalf=""
batteryQuater=""
batteryEmpty=""

statusCache=~/.cache/battery/lastStatus

# Fetch data
## Status: Charging, Full, Discharging
status="$( acpi | grep -oP 'Battery 0:.*?\K\w+' )"
percentage="$( acpi | grep -oP '[0-9]+(?=%)' )"
time="$( acpi | grep -oP 'Battery 0:.*?\K\d\d:\d\d+' )"

#doFixData() {
#    # If time is not defined
#    if [[ -z "$time" ]]
#    then
#        time="__:__"
#    fi
#
#    # ACPI is sometimes buggy  when battery is closed to full
#    # Set battery to be full when charging and at 99%
#    if [[ "$percentage" -ge 99 && "$status" != "Discharging" ]]
#    then
#        status="Full"
#        percentage=100
#    fi
#
#    # Battery is sometimes full, but percentage not 100
#    if [[ "$status" = "Full" && "$percentage" != "100" ]]
#    then
#        percentage=100
#    fi
#}

getColoredPercentage() {
    ## Return colored percentage depending on battery level

    # Fetch colors from .Xresources
    local critical=$(xrdb -query | grep '*color1:'| awk '{print $NF}')
    local low=$(xrdb -query | grep '*color3:'| awk '{print $NF}')

    if [ $percentage -le 15 ]
    then
        echo "<span foreground=\"${critical}\">$percentage</span>"
    elif [ $percentage -le 40 ]
    then
        echo "<span foreground=\"${low}\">$percentage</span>"
    else
        echo "$percentage"
    fi
}

getBatteryIcon() {
    ## Set the icon according the battery level

    if [[ $percentage -le 10 ]]
    then
        echo $batteryEmpty
    elif [[ $percentage -le 35 ]]
    then
        echo $batteryQuater
    elif [[ $percentage -le 65 ]]
    then
        echo $batteryHalf
    elif [[ $percentage -le 90 ]]
    then
        echo $batteryThreeQuaters
    else
        echo $batteryFull
    fi
}

getStatusMessage() {
    ## Echo status message for the status bar

    case "$status" in
        Charging)
            local out="$chargingIcon $percentage% $time"
            ;;
        Discharging)
            local out="$(getBatteryIcon) $(getColoredPercentage)% $time"
            ;;
        Full)
            local out="$chargingIcon $percentage%"
            ;;
        Unknown)
            local out="$chargingIcon $percentage% $time"
            ;;
        *)
            local out="$percentage% $status"
            ;;
    esac

    echo "$out"
}

doStatusNotify() {
    ## Send dunst messages in specific occasions

    # Check if cache file exists
    if [[ -f $statusCache ]]
    then
        # Read previous status and analyse difference
        local previousStatusCache=$(<$statusCache)

        ## TODO Do some usefull stuff
        local previousStatus="$( echo $previousStatusCache | grep -oP '^(\w)+' )"
        local previousPercentage="$( echo $previousStatusCache | grep -oP '(\w)+$' )"
        #echo "$previousStatus $previousPercentage"

        ## AC gets unplugged
        #if [[ "$previousStatus" == "Full" ]] && [[ "$status" == "Discharging" ]]
        #then
        #    ~/bin/notifier -a "batteryChecker" -u normal "AC Disconnected"
        #fi

        ## AC gets plugged in
        #if [[ "$previousStatus" != "Full" && "$previousStatus" != "Charging" ]] && [[ "$status" == "Charging" || "$status" == "Full" ]]
        #then
        #    ~/bin/notifier -a "batteryChecker" -u normal "AC Connected"
        #fi

        # Send percentage notification when on battery
        if [[ "$status" == "Discharging" ]]
        then
            if (( $previousPercentage > 75 && $percentage <= 75 ))
            then
                 displayer dunstify -a "batteryChecker" -u low "Battery" "75%"
            elif (( $previousPercentage > 50 && $percentage <= 50 ))
            then
                 displayer dunstify -a "batteryChecker" -u normal "Battery" "50%"
            elif (( $previousPercentage > 35 && $percentage <= 35 ))
            then
                 displayer dunstify -a "batteryChecker" -u normal "Battery" "35"
            elif (( $previousPercentage > 25 && $percentage <= 25 ))
            then
                 displayer dunstify -a "batteryChecker" -u normal "Low Battery" "25%"
            elif (( $previousPercentage > 20 && $percentage <= 20 ))
            then
                 displayer dunstify -a "batteryChecker" -u normal "Low Battery" "20%"
            elif (( $previousPercentage > 15 && $percentage <= 15 ))
            then
                 displayer dunstify -a "batteryChecker" -u critical "Low Battery" "15%"
            elif (( $previousPercentage > 10 && $percentage <= 10 ))
            then
                 displayer dunstify -a "batteryChecker" -u critical "Critical Battery" "10%"
            elif (( $previousPercentage > 5 && $percentage <= 5 ))
            then
                 displayer dunstify -a "batteryChecker" -u critical "Critical Battery" "5%"
            elif (( $previousPercentage > 2 && $percentage <= 2 ))
            then
                 displayer dunstify -a "batteryChecker" -u critical "2%"
            fi
        fi

        # Write current status to file
        if [[ "$status" != "Unknown" ]]
        then
            echo "$status, $percentage" > $statusCache
        fi

    else
        # Create dir and write current status to file
        mkdir -p "$(dirname $statusCache)"
        echo "$status, $percentage" > $statusCache
    fi
}

while getopts 'sc' flag
do
    case "${flag}" in
        s)
            echo "$(getStatusMessage)"
            ;;
        c)
            echo "$(doStatusNotify)"
            ;;
        *)
            echo "Flags: -s -c"
            exit 1 ;;
    esac
done
