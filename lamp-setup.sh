#!/bin/bash 
# lamp-setup.sh
# Script for the setup of a LAMP stack on a Ubuntu 14.04 LTS server with:
# apache2
# php
# 

echo "*** Installing apache..."
sudo apt-get -y update
sudo apt-get -y install apache2

echo "*** Installing php..."
sudo apt-get -y install php5 php5-mysql php5-gd php5-mcrypt php-pear

echo "*** Installing mysql..."
sudo apt-get -y install mysql-server
sudo mysql_install_db
sudo mysql_secure_installation
