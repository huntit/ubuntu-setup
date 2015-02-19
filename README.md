# Standard server config scripts for Ubuntu 14.04 LTS server

Pre-requisites:
* git:
sudo apt-get -y install git
git clone https://github.com/huntit/ubuntu-setup.git

* new user with sudo rights:
sudo adduser <username>
sudo usermod -a -G sudo <username>


#base-setup.sh
* ufw firewall (allowed ports: 80, 222, 443, 10000)
* ssh server on port 222 (root login disabled)
* nano, joe, mc
* Webmin

#lamp-setup.sh
* apache
* mysql


#rails-setup.sh
* PHP for nginx
* Ruby 2.0.0
* RVM
* bundler
* nodejs
* passenger + nginx web server
* MySql


