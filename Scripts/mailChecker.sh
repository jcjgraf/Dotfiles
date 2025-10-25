#!/usr/bin/env bash

set -u
set -e
set -o pipefail

exec 3>&1

MAIL_ROOT=~/.local/share/mail/
MAIL_ADDRS=("graf.jeanclaude@gmail.com" "jeanggi90@gmail.com" "mail@jeanclaudegraf.ch" "ml@jeanclaudegraf.ch" "bienen@jeanclaudegraf.ch" "jegraf@ethz.ch" "jegraf@fotokommission.ch" "jeanclaude.graf@thealternative.ch")
MAIL_INBOX=("/INBOX/cur" "/INBOX/new")

LONGOPTS="check,verbose,help"
OPTIONS=cvh

function usage() {
    echo "Usage: $0 [OPTION]..."
    echo ""
    echo "Options:"
    echo "  --check, -c     Check for new mail."
    echo "  --verbose, -v   Verbose logging."
    echo "  --help, -h      Show this help message"
    echo ""
}

function log() {
    if [ "$verbose" = true ]; then
        printf "%s %s\n" "$(date +"%H:%M:%S")" "$*" 1>&3
    fi
}

function log_err() {
    printf "%s ERROR: %s\n" "$(date +"%H:%M:%S")" "$*" >&2
}

function log_err_msg() {
    log_err $@
    displayer notify-send -u critical "SYNC ERROR" "$*\n"
}

# -temporarily store output to be able to check for errors
# -activate quoting/enhanced mode (e.g. by writing out “--options”)
# -pass arguments only via   -- "$@"   to separate them correctly
# -if getopt fails, it complains itself to stdout
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@") || exit 2
# read getopt’s output this way to handle the quoting right:
eval set -- "$PARSED"

verbose=false
check=false

while true; do
    case "$1" in
        -c|--check)
            shift
            check=true
            ;;
        -v|--verbose)
            verbose=true
            shift
            ;;
        -h|--help)
            usage
            exit 1
            ;;
        --)
            shift
            break;
            ;;
        *)
            echo "Invalid option \"$1\""
            usage
            exit 2
            ;;
    esac
done

function checkForMails() {
    for i in "${!MAIL_ADDRS[@]}"; do
        local addr="${MAIL_ADDRS[i]}"
        log "mbsync $addr"
        status=$(mbsync "$addr" | grep '^Channels:')
        # status="echo \"Channels: 1    Boxes: 9    Far: +1 *2 #3 -4    Near: +5 *6 #7 -8\""
        # log "Status:\n$status"

        pattern='Far: \+([0-9]+) \*([0-9]+) #([0-9]+) -([0-9]+).*Near: \+([0-9]+) \*([0-9]+) #([0-9]+) -([0-9]+)'

        if [[ $status =~ $pattern ]]; then
            f1="${BASH_REMATCH[1]}"
            f2="${BASH_REMATCH[2]}"
            f3="${BASH_REMATCH[3]}"
            f4="${BASH_REMATCH[4]}"
            n1="${BASH_REMATCH[5]}"
            n2="${BASH_REMATCH[6]}"
            n3="${BASH_REMATCH[7]}"
            n4="${BASH_REMATCH[8]}"
            # echo "Far:  $f1 $f2 $f3 $f4"
            # echo "Near: $n1 $n2 $n3 $n4"

            local msg=""

            if (( n1 == 1 )); then
                local msg="$n1 new mail for $addr"
            fi

            if (( n1 > 1 )); then
                local msg="$n1 new mail for $addr"
            fi

            if [[ -n $msg ]]; then
                displayer dunstify --replace="104765${i}" --appname "mailChecker" --urgency normal "$msg"

            fi
        else
            log_err_msg "Failed to match output"
            exit 1
        fi
    done

    log "Update notmuch database"
    notmuch new >/dev/null 2>&1
}

if [[ $check = true ]]; then
    checkForMails
fi

# if [[ $inbox = true ]]; then
#
# fi



# lastUnreadMailNumberDir=~/.cache/mailCheck/lastUnreadMailNumber
#
# for addr in "${diff[@]}"; do
#     echo "$addr"
# done
#
# log "Here"
#
# getNumberOfUnreadMails() {
#     ## Retrieves the total number of unread mails from a maildir
#     local totalUnread=0
#
#     for i in "${MAIL_ADDRS[@]}"
#     do
#         for j in "${MAIL_INBOX[@]}"
#         do
#             local inboxDir="${MAIL_ROOT}${i}${j}"
#             local unread=$(find $inboxDir -type f | grep -vE ',[^,]*S[^,]*$' | wc -l)
#             totalUnread=$(($totalUnread + $unread))
#         done
#     done
#
#     echo $totalUnread
# }
#
# checkForNewMails() {
#     ## Fetch mails and check if there are new ones
#
#     # Read current mail number from file
#     if [[ -f $lastUnreadMailNumberDir ]]
#     then
#         local currentMailNumber=$(<$lastUnreadMailNumberDir)
#     else
#         mkdir -p "$(dirname $lastUnreadMailNumberDir)"
#         local currentMailNumber=0
#     fi
#
#     # Fetch new mails and update cache file
#     mbsync -a
#
#     local newMailNumber="$(getNumberOfUnreadMails)"
#
#     echo "$newMailNumber" > $lastUnreadMailNumberDir
#
#     # Send notification
#     local diffMailNumber=$(( $newMailNumber - $currentMailNumber ))
#     if [[ $diffMailNumber -gt 0 ]]
#     then
#         if [[ $diffMailNumber -eq 1 ]]
#         then
#             local message="There is 1 new mail"
#         else
#             local message="There are $diffMailNumber new mails"
#         fi
#         displayer dunstify -a "mailChecker" -u normal "$message"
#     fi
# }
#
# while getopts 'sc' flag
# do
#     case "${flag}" in
#         s)
#             echo $(getNumberOfUnreadMails)
#             ;;
#         c)
#             checkForNewMails
#             ;;
#         *)
#             echo "Flags: -s, -c"
#             exit 1 ;;
#     esac
# done
