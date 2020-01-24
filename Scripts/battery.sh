#!/bin/bash

chargingIcon=""
batteryFull=""
batteryThreeQuaters=""
batteryHalf=""
batteryQuater=""
batteryEmpty=""


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

echo "$(getStatusMessage)"
