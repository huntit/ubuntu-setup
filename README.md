# Standard server config scripts for Ubuntu 14.04/16.04/18.04 LTS server

Pre-requisites:
* git (if not already installed):
`sudo apt-get -y install git`

* new user with sudo rights:
```
adduser example_user
adduser example_user sudo
```

# Clone repo:
`git clone https://github.com/huntit/ubuntu-setup.git`

# Run scripts:
`sudo ./base-setup.sh`

# base-setup.sh
* ufw firewall (allowed ports: 80, 222, 443, 10000)
* ssh server on port 222 (root login disabled)
* nano, joe, mc

# Now can login using:
`ssh -p 222 username@servername.com`

# To switch SSH to using Public Key Auth. only:
* Make .ssh directory on server:
`mkdir -p ~/.ssh && sudo chmod -R 700 ~/.ssh/`

* Copy public key from local Mac:
`scp -P 222 ~/.ssh/id_rsa.pub user@servername.com:~/.ssh/authorized_keys`

* Secure .ssh directory and authorized_keys on server:
`sudo chmod -R 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys`

# webmin-setup.sh
* webmin web console
* After install, login to https://your_server_ip:10000 and update packages

# virtualmin-setup.sh
* Virtualmin LAMP stack (Apache, MySQL, PHP, BIND, Postfix, DoveCot, etc) + hosting console
* Allow port TCP 21 for FTP

After install, login to https://your_server_ip:10000 and run through setup wizard
* Disabled FirewallD on boot, and enable ufw
* Set passive port range for ProFTPD to 59000-59999

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


