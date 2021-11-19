#!/bin/sh
set -exu

sudo apt -y install git unclutter accountsservice

mkdir -p ~/.config/lxsession/LXDE-pi || true
cat > /home/pi/.config/lxsession/LXDE-pi/autostart <<EOL
@lxpanel --profile LXDE-pi 
@pcmanfm --desktop --profile LXDE-pi 
@xset s noblank 
@xset s off 
@xset –dpms 
@unclutter -idle 0 
@/bin/bash /home/pi/kiosk/runkiosk.sh 
EOL
chmod +x /home/pi/.config/lxsession/LXDE-pi/autostart

mkdir -p /home/pi/kiosk/ || true
cat > /home/pi/kiosk/runkiosk.sh <<EOL
sleep 10
# TODO: after an update, xset is needed here to keep to screen on. Maybe there's a better way to do this.
DISPLAY=:0.0 /usr/bin/xset s noblank
DISPLAY=:0.0 /usr/bin/xset s off
DISPLAY=:0.0 /usr/bin/xset -dpms
DISPLAY=:0.0 /usr/bin/chromium-browser --noerrdialogs --disable-infobars --kiosk /media/pi/MENU/*.jpg 
EOL
chmod +x /home/pi/kiosk/runkiosk.sh

sudo systemctl disable ssh
echo "dtoverlay=disable-bt" | sudo tee -a /boot/config.txt
echo "dtoverlay=disable-wifi" | sudo tee -a /boot/config.txt

git clone https://github.com/JasperE84/root-ro.git 
cd root-ro || exit 1
    chmod +x install.sh 
    sudo ./install.sh 
cd -
