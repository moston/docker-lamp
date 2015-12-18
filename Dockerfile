################################################################################
# Base image
################################################################################

FROM php:5.6-apache

################################################################################
# Build instructions
################################################################################

# Install packages
RUN apt-get update && apt-get install -my \
  supervisor \
  curl \
  wget \
  mcrypt \
  php5-curl \
  php5-gd \
  php5-memcached \
  php5-mysqlnd \
  php5-mcrypt \
  php5-sqlite \
  php5-xdebug \
  php5-redis \
  openssh-server \
  libmcrypt-dev \
  libpng12-dev \
  libbz2-dev \
  php-pear \
  curl \
  git 

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

RUN a2enmod rewrite ;\
    a2enmod expires ;\
    a2enmod headers ;\
    a2enmod deflate ;\
    a2enmod remoteip ;

RUN docker-php-ext-install \
    zip \
    bz2 \
    iconv \
    mcrypt \
    mbstring

# Add configuration files
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

################################################################################
# Volumes
################################################################################

VOLUME ["/var/www/html", "/etc/apache2/sites-enabled"]

################################################################################
# Ports
################################################################################

EXPOSE 80 443

################################################################################
# Entrypoint
################################################################################

CMD /usr/bin/supervisord