# Standard server config scripts for Ubuntu 14.04/16.04/18.04/24.04 LTS server

# Login to console

Pre-requisites:
* git (if not already installed):
```bash
sudo apt-get -y install git
```

* Set the hostname:
```bash
hostnamectl set-hostname discovery
```

* Set the timezone:
```bash
sudo dpkg-reconfigure tzdata
```

* Edit hosts file and add FQDN and hostname for external IP address:
```bash
sudo nano /etc/hosts
203.0.113.10 hostname.example.com hostname
```

* Add new user with sudo rights:
```bash
adduser example_user
adduser example_user sudo
```

# Clone repo:
```bash
git clone https://github.com/huntit/ubuntu-setup.git
```

# Run scripts:
```bash
sudo ./base-setup.sh
```

# base-setup.sh
* ssh server on port 222 (root login disabled)
* nano, joe, mc
* Note: Firewall configuration is handled by Virtualmin (firewalld)

# Now can login via SSH using:
```bash
ssh -p 222 username@servername.com
```

# To switch SSH to using Public Key Auth. only:
* Make .ssh directory on server:
```bash
mkdir -p ~/.ssh && sudo chmod -R 700 ~/.ssh/
```

* Copy public key from local Mac:
```bash
scp -P 222 ~/.ssh/id_rsa.pub user@servername.com:~/.ssh/authorized_keys
```

* Secure .ssh directory and authorized_keys on server:
```bash
sudo chmod -R 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys
```

* Change sshd to disallow password authentication:
```bash
sudo nano /etc/ssh/sshd_config
```

* Change PasswordAuthentication to no to disable tunnelled clear text passwords
```
PasswordAuthentication no
```

* Restart SSHD:
```bash
sudo systemctl restart ssh
```
# Enable Unattended Security Updates:
[Automatic Updates - Ubuntu 18.04 Documentation](https://help.ubuntu.com/lts/serverguide/automatic-updates.html)

[How to setup automatic updates on Ubuntu 18.04](https://libre-software.net/ubuntu-automatic-updates/)

# How To Secure Your Server (Linode)
[How to Secure Your Server](https://www.linode.com/docs/security/securing-your-server/)

# webmin-setup.sh
* webmin web console
* After install, login to https://your_server_ip:10000 and update packages

# virtualmin-setup.sh
* Use ./virtualmin-setup.sh --minimal for a minimal install (without SpamAssassin, ClamAV, etc for lower memory use)
* Virtualmin LAMP stack (Apache, MySQL, PHP, BIND, Postfix, DoveCot, etc) + hosting console
* Allow port TCP 21 for FTP

After install, login to https://your_server_ip:10000 and run through setup wizard
* Virtualmin will install and configure firewalld, MariaDB, and other services
* Set passive port range for ProFTPD to 59000-59999:
Servers - ProFTPD Server - Networking Options - PASV Port Range: 59000-59999

* Edit ProFTPD settings to allow FTP over TLS:
Edit Config Files: /etc/proftpd/conf.d/virtualmin.conf
TLSRequired on
TLSOptions AllowClientRenegotiations NoCertRequest NoSessionReuseRequired
TLSProtocol TLSv1.2


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


