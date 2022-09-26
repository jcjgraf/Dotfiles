#!/bin/sh

if [[ "$1" =~ ^/[A-Za-z0-9._%+-]+/[A-Za-z0-9._%+-]+/[A-Za-z0-9._%+-]+$ ]]; then

    sudo umount ${1}
    sudo cryptsetup close ${1}

    echo "Unmounted and closed ${1}"

else
    echo "Format should be /xxx/xxx/xxx"
fi
