FROM amazonlinux:2018.03
MAINTAINER "Imran Shahid" <narmi79@gmail.com>

# define grav version
ARG GRAV_VERSION=1.6.10

# install dependencies
RUN yum -y install sudo wget zip unzip && \
    sudo yum -y update && \
    sudo yum -y remove httpd* php* && \
    sudo yum -y install httpd24 && \
    sudo yum -y install php71 php71-pear php71-mbstring php71-cli php71-imap php71-gd php71-xml php71-soap php71-pecl-apc

# create group www and add user apache to it
RUN sudo groupadd www && \
    sudo usermod -a -G www apache

# install grav
RUN cd ~ && \
    wget https://github.com/getgrav/grav/releases/download/$GRAV_VERSION/grav-admin-v$GRAV_VERSION.zip -O grav-admin-$GRAV_VER.zip && \
    unzip grav-admin-$GRAV_VER.zip && \
    mv /var/www/html /var/www/html.old && \
    mv grav-admin /var/www/html && \
    rm -rf grav-admin-*

# configure grav
RUN cd /var/www/html && \
    chown -R apache:www . && \
    find . -type f | xargs chmod 664 && \
    find ./bin -type f | xargs chmod 775 && \
    find . -type d | xargs chmod 775 && \
    find . -type d | xargs chmod +s && \
    umask 0002

# setup and start apache
COPY files/httpd.conf /etc/httpd/conf/httpd.conf
RUN sudo service httpd start && \
    sudo chkconfig httpd on

# expose apache port
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
