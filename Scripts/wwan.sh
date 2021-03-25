#!/bin/bash
## wwan controller

modulePath=/home/jeanclaude/.local/share/xmm7360-pci

enableWwan(){
	#disable wlan
	nmcli radio wifi off

	#build module
	cd $modulePath
	sudo make clean
	sudo make

	#load module
	sudo make load

	#start wwan
	sudo python rpc/open_xdatachannel.py --apn dr.m2m.ch

	cd -
}

disableWwan(){
	#disable wwan
	sudo ip link set wwan0 down

	#unload module
	cd $modulePath

	sudo make unload

	#enable wlan
	nmcli radio wifi on

	cd -
}

usage(){
	echo "Usage: $0
		-u enable Wwan
		-d disable Wwan
		-h help" 1>&2; exit 1;
}

if [[ $# -eq 0 ]]
then
	wwanCheck=$(ip a | grep wwan0)
	if [ -n "$wwanCheck" ]
	then
		displayer dunstify -a "wwanController" "Disable WWAN"
		disableWwan
	else
		displayer dunstify -a "wwanController" "Enable WWAN"
		enableWwan
	fi
fi

while getopts 'udh' flag
do
	case "${flag}" in
		u)
			enableWwan
			;;
		d)
			disableWwan
			;;
		h | *)
			usage
			;;
	esac
done
