#!/bin/bash 
# base-setup.sh
# Script for base setup of a Ubuntu 14.04/16.04/18.04 LTS server with:
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

# Clear out any existing itables firewall rules
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -F
sudo iptables -X

# Enable ufw firewall and allow ports 222, 80, 443, 10000, 21
echo "*** Enabling firewall and setting rules ..."
# reset all firewall rules to default deny all incoming
yes | sudo ufw reset --force
sudo ufw allow 222 
sudo ufw allow http 
sudo ufw allow 443
sudo ufw allow 10000
# FTPS ports:
sudo ufw allow 21/tcp
sudo ufw allow 59000:59999/tcp
yes | sudo ufw enable
yes | sudo ufw status verbose
sudo systemctl enable ufw

# Install ssh to port 222
echo "*** Installing ssh ..."
sudo apt-get -y install openssh-server
# Search and replace sshd_config, look for Port xxx and replace with Port 222, set PermitRootLogin to NO
sudo sed -i 's/Port .*/Port 222/' /etc/ssh/sshd_config
sudo sed -i 's/#Port 222/Port 222/g' /etc/ssh/sshd_config
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

echo "*** base-setup.sh finished at $(date) ***"

read -p "*** Setup script finished. Press Enter to continue ***"


