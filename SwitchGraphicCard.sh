#!/bin/bash


if ! [ $(id -u) = 0 ]; then
   echo "This script must be run as root"
   exit 1
fi

echo "This program is for switch graphic card"

while true
do 
	read -p "Please select options (1) Intel (2) Nvidia " graphicCard
	case $graphicCard in
		"1")
		echo "Select Intel Graphic Card"
		sudo prime-select intel
		break;
		;;
		"2")
	 	echo "Select Nvidia Graphic Card"
		sudo prime-select nvidia
		break;
		;;
		*)
		echo "Please input 1 or 2"
	esac
done

read -p "Do you need reboot now to apply new change? Y/N " reboot
if [ $reboot == "y" ] || [ $reboot == "Y" ];
	then sudo reboot now
else 
	echo "You need reboot to apply new change"
fi


