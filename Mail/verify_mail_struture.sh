#!/usr/bin/env bash
set -e
set -u
set -o pipefail


MAIL_ROOT="~/.local/share/mail"
REQUIRED_MAILBOXES=("INBOX" "Drafts" "Junk" "Archive" "Sent" "Trash")

status=0



# Iterate over each email address directory
for email_dir in "$MAIL_ROOT"/*; do
    [[ -d "$email_dir" ]] || continue
    echo "Checking: $(basename "$email_dir")"

    # 1. Check required mailboxes
    for box in "${REQUIRED_MAILBOXES[@]}"; do
        if [[ ! -d "$email_dir/$box" ]]; then
            echo "  ❌ Missing mailbox: $box"
            status=1
        else
            # 3. Check for 'cur' directory inside
            if [[ ! -d "$email_dir/$box/cur" ]]; then
                echo "  ❌ Missing 'cur' inside $box"
                status=1
            fi
        fi
    done

    # 2. Check all mailboxes for symlink rule
    for mailbox in "$email_dir"/*; do
        [[ -e "$mailbox" ]] || continue
        box_name=$(basename "$mailbox")

        if [[ ! " ${REQUIRED_MAILBOXES[*]} " =~ " $box_name " ]]; then
            if [[ -L "$mailbox" ]]; then
                target=$(readlink "$mailbox")
                # Must point to one of A/B/C
                if [[ ! " ${REQUIRED_MAILBOXES[*]} " =~ " $(basename "$target") " ]]; then
                    echo "  ❌ Symlink $box_name → $target does not point to A/B/C"
                    status=1
                fi
            else
                echo "  ❌ Mailbox '$box_name' is not A/B/C and not a symlink"
                status=1
            fi
        fi
    done
done

if [[ $status -eq 0 ]]; then
    echo "✅ All checks passed."
else
    echo "⚠ Some checks failed."
fi

exit $status
