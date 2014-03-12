#!/bin/bash 
# setupserver.sh
# Script to setup a Ubuntu 12.04 LTS server with:
# ufw firewall
# ssh server
# nginx web server

# Output to a LOG file, as well as the console
exec > >(tee setupserver.log)
echo "*** Running setupserver.sh at $(date) ***"

#sudo apt-get -y update
#sudo apt-get -y upgrade

echo "*** Installing git..."
sudo apt-get -y install git

# Enable ufw firewall and allow ports 222, 80, 443
echo "*** Enabling firewall ..."
# reset all firewall rules
yes | sudo ufw reset --force

sudo ufw allow 222 
sudo ufw allow http 
sudo ufw allow 443
sudo ufw allow 5900
sudo ufw allow 5901
sudo ufw enable
sudo ufw status verbose

# Install ssh to port 222
echo "*** Installing ssh ..."
sudo apt-get -y install openssh-server
# Search and replace sshd_config, look for Port xxx without a # in front and replace with Port 222
sudo sed -i 's/Port .*/Port 222/' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
# To configure ssh: sudo gedit /etc/ssh/sshd_config
echo "*** Contents of sshd_config ..."
sudo cat /etc/ssh/sshd_config
sudo restart ssh

# Install nginx
echo "*** Installing nginx ..."
sudo apt-get -y install nginx

# Start nginx
sudo service nginx start

echo "*** setupserver.sh finished at $(date) ***"

read -p "*** Setup script finished ***"


