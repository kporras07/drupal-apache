FROM phusion/baseimage:0.9.15
MAINTAINER Jose M. Santibanez <jmsv23@gmail.com>
 
ENV HOME /root
ADD ./sh/start.sh /start.sh
 
RUN apt-get update -q

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

COPY ssh/id_rsa.pub $HOME/.ssh/authorized_keys
COPY ssh/sshd_config /etc/ssh/sshd_config

RUN apt-get install -y apache2 \
wget \
curl \
git \
php5 \
php-pear \
php5-common \
php5-curl \
php5-gd \
php5-json \
php5-mysql \
php5-readline


RUN echo "mysql-server-5.5 mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get install -y mysql-server

WORKDIR /opt

RUN git clone https://github.com/drush-ops/drush.git
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

WORKDIR /opt/drush

RUN composer install
RUN ln -s /opt/drush/drush /usr/local/bin/drush

RUN mkdir /home/www
RUN chown -R www-data:www-data /home/www

COPY apache-conf/drupal.conf /etc/apache2/sites-available/

WORKDIR /etc/apache2/sites-enabled
RUN rm 000-default.conf
RUN ln -s /etc/apache2/sites-available/drupal.conf drupal.conf
 
EXPOSE 22
EXPOSE 80

RUN chmod 755 /start.sh
 
CMD ["/bin/bash","/start.sh"]