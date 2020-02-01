#!/bin/bash
## Backup Script

cacheDir=~/.cache/backup/
lastStatusCache=lastStatus
uuidCache=uuid
destinationCache=destination
sourceCache=source

loadFromCache() {
    # Load all cache variables to memory

    # Check if cachedir
    if [[ ! -d "$cacheDir" ]]
    then
        return 2
    fi

    # Load existing valiables
    if [[ -f "$cacheDir$uuidCache" ]]
    then
        uuid=$(<"$cacheDir$uuidCache")
    fi

    if [[ -f "$cacheDir$destinationCache" ]]
    then
        destinationPath=$(<"$cacheDir$destinationCache")
    fi

    if [[ -f "$cacheDir$sourceCache" ]]
    then
        sourcePath=$(<"$cacheDir$sourceCache")
    fi
}

sendBackupRemainder() {
    # Check when the last backup was made

    if [[ -f "$cacheDir$statusCache" ]]
    then
        local lastBackupDate=$(<"$cacheDir$statusCache")
        local daysAgo=$(( ($(date +%s) - $lastBackupDate) / (60*60*24) ))

        case $daysAgo in
            0)
#                ~/bin/notifier -a "backup" -u low "No backup required" "Last backup was created today. There is no need for creating a new one"
                ;;
            1)
#                ~/bin/notifier -a "backup" -u low "Everything alright" "Last backup was created yesterday. Everything is alright"
                ;;
            2)
                ~/bin/notifier -a "backup" -u normal "Consider creating a backup" "Last backup was created two days ago. Occasionally create a new one"
                ;;
            3)
                ~/bin/notifier -a "backup" -u normal "Time for a new backup" "Last backup was created three days ago. Consider creating a new one"
                ;;
            4)
                ~/bin/notifier -a "backup" -u critical "It is seriously time for a backup" "Last backup was created four days ago. Create one today!"
                ;;
            *)
                ~/bin/notifier -a "backup" -u critical "It is seriously time for a backup" "Last backup was created a few ages ago. Create one today!"
                ;;
        esac
    else
        # No backup yet made
        ~/bin/notifier -a "backup" -u critical "No backup made" "No backup was made so far. Consider running the script to backup this computer."
    fi

}

isDriveConnected() {
    # Check if the harddrive with uuid is connected

    # If uuid not set, load it
    if [[ -z ${uuid} ]]
    then
        # Try loading variables
        loadFromCache
    fi

    # Check if device with given uuid is connected
    if [[ "$(lsblk -f | grep -c $uuid)" -eq 1 ]]
    then
        return 0
    else
        return 6
    fi
}

writeToCache() {
    # Check if $chachedir and file $2 exist and writes $1 to it

    # Create cache directory if not existing
    if [[ ! -d "$cacheDir" ]]
    then
        mkdir $p "$cacheDir"
    fi

    # Write $1 to $2 if both supplied
    if [[ ! -z "$1" && ! -z "$2" ]]
    then
        echo "$1" > "$cacheDir$2"
    else
        return 5
    fi
}

writeNewStatus() {
    # Write current time to cache

    writeToCache "$( date +%s )" $statusCache
}

createBackup() {
    # Tries to backup
    return 0
}

usage() { echo "Usage: $0 -h -c -u <UUID> -s <Source> -d <Destination> -i" 1>&2; exit 1; }

# Check passed flags
[[ $# -eq 0 ]] && usage
while getopts 'hcu:s:d:i' flag
do
    case "${flag}" in
        c)
            # Check last backup
            echo "$(sendBackupRemainder)"
            ;;
        u)
            # UUID
            s=$OPTARG
            writeToCache $s $uuidCache
            echo "Successfully added UUID $s"
            ;;
        s)
            # Source
            s=$OPTARG
            writeToCache $s $sourceCache
            echo "Successfully added source $s"
            ;;
        d)
            # Destination
            s=$OPTARG
            writeToCache $s $destinationCache
            echo "Successfully added destination $s"
            ;;
        i)
            # Information
            loadFromCache
            printf "Source: $sourcePath \nDestination: $destinationPath \nUUID: $uuid"
            ;;
        h | *)
            usage
            ;;
    esac
done
