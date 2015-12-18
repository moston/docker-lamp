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
  php5-curl \
  php5-gd \
  php5-memcached \
  php5-mysql \
  php5-mcrypt \
  php5-sqlite \
  php5-xdebug \
  php5-redis \
  openssh-server

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

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