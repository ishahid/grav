FROM amazonlinux:2017.09
MAINTAINER "Imran Shahid" <narmi79@gmail.com>

RUN yum -y install sudo wget zip unzip && \
    sudo yum -y update

RUN sudo yum -y install httpd24 php56-devel php56-pear php56-mbstring php56-cli php56-imap php56-gd php56-xml php56-soap php56-pecl-apc
    
RUN sudo groupadd www && \
    sudo usermod -a -G www apache

RUN cd ~ && \
    wget https://getgrav.org/download/core/grav-admin/1.3.10 -O grav-admin-1.3.10.zip && \
    unzip grav-admin-1.3.10.zip && \
    mv /var/www/html /var/www/html.old && \
    mv grav-admin /var/www/html && \
    rm -rf grav-admin-*
    
RUN cd /var/www/html && \
    chown -R apache:www . && \
    find . -type f | xargs chmod 664 && \
    find ./bin -type f | xargs chmod 775 && \
    find . -type d | xargs chmod 775 && \
    find . -type d | xargs chmod +s && \
    umask 0002

COPY files/httpd.conf /etc/httpd/conf/httpd.conf
RUN sudo service httpd start && \
    sudo chkconfig httpd on

EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
