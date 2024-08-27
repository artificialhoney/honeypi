#/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo apt-get install -y \
    xorg \
    x11-xserver-utils \
    xserver-xorg-video-fbdev \
    xserver-xorg-video-fbturbo \
    fonts-noto-color-emoji \
    feh \
    gjs \
    gnome-themes-standard \
    gir1.2-webkit2-4.0 \
    cec-utils \
    xdotool \
    vim

echo -n "${HONEYPI_KIOSK_USER:='pi'}:"  | sudo tee /boot/userconf.txt
openssl passwd -5 "${HONEYPI_KIOSK_PASSWORD:='raspberry'}" | sudo tee -a /boot/userconf.txt
sudo touch /boot/ssh

echo "${HONEYPI_KIOSK_URL}" | sudo tee /boot/kiosk.url
sudo chown 1000:1000 /boot/kiosk.url

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
export DEBIAN_FRONTEND=noninteractive

sudo cp -f $SCRIPT_DIR/files/config.txt /boot
sudo chmod 644 /boot/config.txt
sudo cp -f $SCRIPT_DIR/files/cmdline.txt /boot
sudo chmod 644 /boot/cmdline.txt

USER_HOME="/home/${HONEYPI_KIOSK_USER}"
mkdir -p $USER_HOME/kiosk

sudo cp -f $SCRIPT_DIR/files/kiosk/kiosk.sh $USER_HOME/kiosk
sudo chmod 755 $USER_HOME/kiosk/kiosk.sh
sudo chown 1000:1000 $USER_HOME/kiosk/kiosk.sh
# sudo cp -f $SCRIPT_DIR/files/firstrun.sh $USER_HOME
# sudo chmod 755 $USER_HOME/firstrun.sh
# sudo chown 1000:1000 $USER_HOME/firstrun.sh

sudo cp -f $SCRIPT_DIR/files/.xinitrc $USER_HOME
sudo chmod 644 $USER_HOME/.xinitrc
sudo chown 1000:1000 $USER_HOME/.xinitrc

sudo sh -c 'echo "
# first-run script
# [[ -f ./firstrun.sh ]] && ./firstrun.sh

# silent startx on video console

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  startx > /dev/null 2>&1
  exit
fi
" >> '$USER_HOME'/.profile'

sudo cp -f $SCRIPT_DIR/files/.hushlogin $USER_HOME
sudo chmod 644 $USER_HOME/.hushlogin
sudo chown 1000:1000 $USER_HOME/.hushlogin

sudo cp -f $SCRIPT_DIR/files/kiosk/splash.png $USER_HOME/kiosk
sudo chmod 755 $USER_HOME/kiosk/splash.png
sudo chown 1000:1000 $USER_HOME/kiosk/splash.png
sudo cp -f $SCRIPT_DIR/files/kiosk/browser $USER_HOME/kiosk
sudo chmod 755 $USER_HOME/kiosk/browser
sudo chown 1000:1000 $USER_HOME/kiosk/browser
sudo cp -f $SCRIPT_DIR/files/kiosk/cec2kbd $USER_HOME/kiosk
sudo chmod 755 $USER_HOME/kiosk/cec2kbd
sudo chown 1000:1000 $USER_HOME/kiosk/cec2kbd

sudo reboot