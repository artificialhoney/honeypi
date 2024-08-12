#!/bin/bash

sudo apt-get install libcamera-tools libcamera-v4l2 motion -y
sudo libcamerify motion

sudo sed -i 's/webcontrol_localhost on/webcontrol_localhost off/g'
sudo sed -i 's/stream_localhost on/webcontrol_localhost off/g'

sudo sed -i 's/ExecStart=\/usr\/bin\/motion/ExecStart=\/usr\/bin\/libcamerify \/usr\/bin\/motion/g'

sudo find /var/log/motion -delete
sudo mkdir /var/log/motion
sudo chown motion:motion /var/log/motion
sudo systemctl enable motion.service
sudo systemctl start motion.service