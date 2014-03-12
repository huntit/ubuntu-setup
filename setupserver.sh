#!/bin/bash 
# setupserver.sh
# Script to setup a Ubuntu 12.04 LTS server with:
# ufw firewall
# ssh server
# Ruby 2.0.0
# RVM
# bundler
# nodejs
# passenger + nginx web server
# mysql

# Output to a LOG file, as well as the console
exec > >(tee setupserver.log)
echo "*** Running setupserver.sh at $(date) ***"

#sudo apt-get -y update
#sudo apt-get -y upgrade

echo "*** Installing git..."
sudo apt-get -y install git
# Set the credential cache to timeout after 1 hour (setting is in seconds)
git config --global credential.helper 'cache --timeout=3600'

# Enable ufw firewall and allow ports 222, 80, 443
echo "*** Enabling firewall and setting rules ..."
# reset all firewall rules to default deny all incoming
yes | sudo ufw reset --force

sudo ufw allow 222 
sudo ufw allow http 
sudo ufw allow 443
sudo ufw allow 5900
sudo ufw allow 5901
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

# Install dependencies for Ruby and RVM
echo "*** Installing ruby dependencies ..."
sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev libcurl4-openssl-dev python-software-properties python g++ make 
echo "*** Installing RVM and Ruby 2.0.0 ..."
sudo apt-get -y install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.0.0
rvm use 2.0.0 --default
ruby -v
echo "*** Installing bundler, rails, rack, rake ..."
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler
gem install rails
gem install rack
gem install rake

# Install nodejs
echo "*** Installing nodejs, please wait ..." 
sudo apt-get -y install software-properties-common
yes | sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get -y install nodejs

# To Remove nginx 
#apt-get remove nginx nginx-full nginx-light nginx-naxsi nginx-common

# Install passenger + nginx
echo "*** Installing passenger + nginx ..."
# Install Phusion's PGP key to verify packages
gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
gpg --armor --export 561F9B9CAC40B2F7 | sudo apt-key add -
# Add HTTPS support to APT
sudo apt-get -y install apt-transport-https
# Add the passenger repository
sudo sh -c "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main' >> /etc/apt/sources.list.d/passenger.list"
sudo chown root: /etc/apt/sources.list.d/passenger.list
sudo chmod 600 /etc/apt/sources.list.d/passenger.list
sudo apt-get update

# Install nginx and passenger
sudo apt-get -y install nginx-full passenger

#sudo apt-get -y install nginx

# Enable Passenger support for nginx in nginx.conf
sudo sed -i 's/# passenger_root/passenger_root/' /etc/nginx/nginx.conf
sudo sed -i 's/# passenger_ruby \/usr\/bin\/ruby;/passenger_root \/home\/peter\/.rvm\/rubies\/ruby-2.0.0-p451\/bin\/ruby;/' /etc/nginx/nginx.conf
cat /etc/nginx/nginx.conf


# Start nginx
sudo service nginx start

# Install MySQL
echo "*** Installing MySQL ..."
sudo apt-get -y install mysql-server mysql-client libmysqlclient-dev


sudo passenger-memory-stats
ruby -v
rails --version

echo "*** setupserver.sh finished at $(date) ***"

read -p "*** Setup script finished ***"

# /etc/nginx/sites-enabled/default

