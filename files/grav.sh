sudo yum -y update
sudo yum -y install wget zip unzip
sudo yum -y remove httpd* php*
sudo yum -y install httpd24
sudo yum -y install php71 php71-pear php71-mbstring php71-cli php71-imap php71-gd php71-xml php71-soap php71-pecl-apc

sudo groupadd www
sudo usermod -a -G www ec2-user
sudo usermod -a -G www apache

sudo service httpd start
sudo chkconfig httpd on

cd ~
wget https://github.com/getgrav/grav/releases/download/1.6.10/grav-admin-v1.6.10.zip -O grav-admin-1.6.10.zip
unzip grav-admin-1.6.10.zip
sudo mv /var/www/html /var/www/html.old
sudo mv grav-admin /var/www/html

cd /var/www/html
sudo chown -R apache:www .
find . -type f | sudo xargs chmod 664
find ./bin -type f | sudo xargs chmod 775
find . -type d | sudo xargs chmod 775
find . -type d | sudo xargs chmod +s
umask 0002

sudo service httpd restart
