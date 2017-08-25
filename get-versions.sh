#!/bin/bash 
# get-versions.sh
# Script to get the versions of installed software on Ubuntu 14.04/16.04 server
# Output to a LOG file, as well as the console

exec > >(tee get-versions.log)
echo "*** Running get-versions.sh at $(date) ***"

echo "***"
echo "*** Getting Ubuntu version..."
lsb_release -a

echo "***"
echo "*** Getting PHP version..."
php -v

echo "***"
echo "*** Getting Apache version..."
sudo apachectl -V


echo "***"
echo "*** Getting MySQL version..."
mysql --version



echo "*** get-versions.sh finished at $(date) ***"

read -p "*** get-versions script finished. Press Enter to continue ***"


