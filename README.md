# Standard server config scripts for Ubuntu 14.04/16.04 LTS server

Pre-requisites:
* git:
sudo apt-get -y install git

* new user with sudo rights:
sudo adduser <username>
visudo

# Clone repo:
git clone https://github.com/huntit/ubuntu-setup.git

# Run scripts:
sudo ./base-setup.sh

# base-setup.sh
* ufw firewall (allowed ports: 80, 222, 443, 10000)
* ssh server on port 222 (root login disabled)
* nano, joe, mc

# webmin-setup.sh
* webmin web console
* After install, login to https://your_server_ip:10000 and update packages

# virtualmin-setup.sh
* Virtualmin LAMP stack (Apache, MySQL, PHP, BIND, Postfix, DoveCot, etc) + hosting console
* Allow port TCP 21 for FTP
* After install, login to https://your_server_ip:10000 and run through setup wizard

# get-versions.sh
* Returns installed version numbers of:
Ubuntu
php
apache
mysql


## Other Scripts

# lamp-setup.sh
* apache
* php
* mysql

# rails-setup.sh
* PHP for nginx
* Ruby 2.0.0
* RVM
* bundler
* nodejs
* passenger + nginx web server
* MySql


