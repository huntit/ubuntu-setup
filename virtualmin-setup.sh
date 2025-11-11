#!/bin/bash 
# virtualmin-setup.sh
# Script for the setup of a LAMP stack with Virtualmin hosting on a Ubuntu 24.04 LTS server

#Installing Virtualmin (Apache, MariaDB, BIND, Postfix, procmail, SpamAssassin, ClamAV, Dovecot, ProFTPd, PostgreSQL, Mailman)
#Use --minimal for a minimal install (without SpamAssassin, ClamAV, etc. for lower memory systems)
#Allow ftp through firewall
#sudo ufw allow 21/tcp
sudo apt-get -y update
echo "*** Installing Virtualmin ..."
#sudo wget http://software.virtualmin.com/gpl/scripts/install.sh
#sudo chmod +x install.sh
#sudo ./install.sh $1
sudo sh -c "$(curl -fsSL https://software.virtualmin.com/gpl/scripts/virtualmin-install.sh)" -- --bundle LAMP


