#!/bin/sh

if [[ "$1" =~ ^/[A-Za-z0-9._%+-]+/[A-Za-z0-9._%+-]+/[A-Za-z0-9._%+-]+$ ]]; then

    name=$( echo ${1} |  cut -d "/" -f 4 )
    group=$( echo ${1} |  cut -d "/" -f 3 )
    passwd=$( pass ${group}/${name} )
    
    pass ${group}/${name} | sudo cryptsetup open ${1} ${name} - && sudo mount /dev/mapper/${name} ${2}

    echo "Decrypted ${1} and mounted to ${2}"

else
    echo "Format should be /xxx/xxx/xxx"
fi
