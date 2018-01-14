sudo yum -y update
sudo yum -y install wget zip unzip
sudo yum -y install httpd24 php56-devel php56-pear php56-mbstring php56-cli php56-imap php56-gd php56-xml php56-soap php56-pecl-apc

sudo groupadd www
sudo usermod -a -G www ec2-user
sudo usermod -a -G www apache

sudo service httpd start
sudo chkconfig httpd on

cd ~ 
wget https://getgrav.org/download/core/grav-admin/1.3.10 -O grav-admin-1.3.10.zip && unzip grav-admin-1.3.10.zip
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
