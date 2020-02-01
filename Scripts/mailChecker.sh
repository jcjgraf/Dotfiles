#!/bin/bash

mailDir=~/.local/share/mail/
addresses=("graf.jeanclaude@gmail.com" "jeanggi90@gmail.com")
mailboxes=("/INBOX/cur" "/INBOX/new")

lastUnreadMailNumberDir=~/.cache/mailCheck/lastUnreadMailNumber

getNumberOfUnreadMails() {
    ## Retrieves the total number of unread mails from a maildir
    local totalUnread=0

    for i in "${addresses[@]}"
    do
        for j in "${mailboxes[@]}"
        do
            local inboxDir="${mailDir}${i}${j}"
            local unread=$(find $inboxDir -type f | grep -vE ',[^,]*S[^,]*$' | wc -l)
            totalUnread=$(($totalUnread + $unread))
        done
    done

    echo $totalUnread
}

checkForNewMails() {
    ## Fetch mails and check if there are new ones

    # Read current mail number from file
    if [[ -f $lastUnreadMailNumberDir ]]
    then
        local currentMailNumber=$(<$lastUnreadMailNumberDir)
    else
        mkdir -p "$(dirname $lastUnreadMailNumberDir)"
        local currentMailNumber=0
    fi

    # Fetch new mails and update cache file
    mbsync -a

    local newMailNumber="$(getNumberOfUnreadMails)"

    echo "$newMailNumber" > $lastUnreadMailNumberDir

    # Send notification
    local diffMailNumber=$(( $newMailNumber - $currentMailNumber ))
    if [[ $diffMailNumber -gt 0 ]]
    then
        if [[ $diffMailNumber -eq 1 ]]
        then
            local message="There is 1 new mail"
        else
            local message="There are $diffMailNumber new mails"
        fi
        ~/bin/notifier -a "mailChecker" -u normal "$message"
    fi
}

while getopts 'sc' flag
do
    case "${flag}" in
        s)
            echo $(getNumberOfUnreadMails)
            ;;
        c)
            checkForNewMails
            ;;
        *)
            echo "Flags: -s, -c"
            exit 1 ;;
    esac
done
