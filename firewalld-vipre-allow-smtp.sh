# firewalld - allow incoming SMTP from VIPRE servers only
# remember to block incoming SMTP on the public zone rules
sudo firewall-cmd --permanent --new-ipset=smtp_allowed_ips --type=hash:net
sudo firewall-cmd --permanent --ipset=smtp_allowed_ips --add-entry=208.70.128.0/21
sudo firewall-cmd --permanent --ipset=smtp_allowed_ips --add-entry=72.35.12.0/24
sudo firewall-cmd --permanent --ipset=smtp_allowed_ips --add-entry=72.35.23.0/24
sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source ipset="smtp_allowed_ips" port port="25" protocol="tcp" accept'
sudo firewall-cmd --reload


