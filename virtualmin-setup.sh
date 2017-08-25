#!/bin/bash 
# virtualmin-setup.sh
# Script for the setup of a LAMP stack with Virtualmin hosting on a Ubuntu 14.04/16.04 LTS server

#Installing Virtualmin (Apache, BIND, Postfix, procmail, SpamAssassin, ClamAV, Dovecot, ProFTPd, MySQL, PostgreSQL, Mailman)
#Allow ftp through firewall
sudo ufw allow 21/tcp
sudo apt-get -y update
echo "*** Installing Virtualmin ..."
sudo wget http://software.virtualmin.com/gpl/scripts/install.sh
sudo chmod +x install.sh
sudo ./install.sh


