#!/bin/bash
if ! [ $(id -u) = 0 ]; then
   echo "This script must be run as root"
   exit 1
fi

#First add yourself to the "input" group and log out/log back in:

sudo gpasswd -a $USER input
#Install all pre-requisite packages:

sudo apt install libinput-tools xdotool ruby
#Install fusuma gem:

sudo gem install fusuma
#Create a configuration file as your user:

mkdir -p ~/.config/fusuma
echo "
swipe:
  3: 
    left: 
      command: 'xdotool key alt+Right'
    right: 
      command: 'xdotool key alt+Left'
    up: 
      command: 'xdotool key super+s'
    down: 
      command: 'xdotool key super+l'
  4:
    up: 
      command: 'xdotool key ctrl+alt+Up'
    down: 
      command: 'xdotool key ctrl+alt+Down'
pinch:
  in:
    command: 'xdotool key ctrl+plus'
  out:
    command: 'xdotool key ctrl+minus'

threshold:
  swipe: 1
  pinch: 1

interval:
  swipe: 1
  pinch: 1" >>  ~/.config/fusuma/config.yml

sudo chmod 777 ~/.config/fusuma/config.yml




echo "[Desktop Entry]
Type=Application
Exec=/usr/local/bin/fusuma
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_SG]=fusuma
Name=fusuma
Comment[en_SG]=
Comment=" >> ~/.config/autostart/fusuma.desktop

sudo chmod 777 ~/.config/autostart/fusuma.desktop

read -p "Do you need reboot now to apply new change? Y/N " reboot
if [ $reboot == "y" ] || [ $reboot == "Y" ];
	then sudo reboot now
else 
	sudo fusuma	
	echo "You need reboot to apply new change"
fi





