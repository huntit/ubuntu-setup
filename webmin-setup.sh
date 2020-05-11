#!/bin/bash 
# webmin-setup.sh
# Script for the setup of Webmin control panel on a Ubuntu 14.04/16.04 LTS server

#Installing webmin
echo "*** Installing webmin ..."
# Add the webmin repository
sudo sh -c "echo 'deb http://download.webmin.com/download/repository sarge contrib' >> /etc/apt/sources.list"
wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install webmin

# Install the Lets Encrypt SSL Client
sudo add-apt-repository ppa:certbot/certbot
sudo apt install python-certbot-apache

# Ubuntu 20.04 LTS - Install the Lets Encrypt SSL Client
sudo apt -y install certbot python3-certbot-apache

