#!/bin/bash 
# base-setup.sh
# Script for base setup of a Ubuntu 14.04 LTS server with:
# ufw firewall with ports allowed
# ssh server on port 222, root login disabled

# Output to a LOG file, as well as the console
exec > >(tee base-setup.log)
echo "*** Running base-setup.sh at $(date) ***"

sudo apt-get -y update
sudo apt-get -y upgrade

echo "*** Configuring git..."
# Set the credential cache to timeout after 1 hour (setting is in seconds)
git config --global credential.helper 'cache --timeout=3600'

# Enable ufw firewall and allow ports 222, 80, 443
echo "*** Enabling firewall and setting rules ..."
# reset all firewall rules to default deny all incoming
yes | sudo ufw reset --force
sudo ufw allow 222 
sudo ufw allow http 
sudo ufw allow 443
sudo ufw allow 10000
yes | sudo ufw enable
yes | sudo ufw status verbose

# Install ssh to port 222
echo "*** Installing ssh ..."
sudo apt-get -y install openssh-server
# Search and replace sshd_config, look for Port xxx without a # in front and replace with Port 222, set PermitRootLogin to NO
sudo sed -i 's/Port .*/Port 222/' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
# To configure ssh: sudo gedit /etc/ssh/sshd_config
echo "*** Contents of sshd_config ..."
sudo cat /etc/ssh/sshd_config
sudo restart ssh

# Installing tools
echo "*** Installing tools (nano, joe, mc) ..."
sudo apt-get -y install nano
sudo apt-get -y install joe
sudo apt-get -y install mc

#Installing webmin
echo "*** Installing webmin ..."
# Add the webmin repository
sudo sh -c "echo 'deb http://download.webmin.com/download/repository sarge contrib' >> /etc/apt/sources.list"
wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install webmin

echo "*** base-setup.sh finished at $(date) ***"

read -p "*** Setup script finished. Press Enter to continue ***"


