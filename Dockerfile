FROM ubuntu:14.04
MAINTAINER r2h2 <rainer@hoerbe.at>

ENV DEBIAN_FRONTEND noninteractive

# --- postfix send-only + httpd/php5
RUN apt-get update  -y \
 && apt-get install -y git curl htop openssl-blacklist \
 && apt-get install -y apache2 \
 && apt-get install -y apache2-doc apache2-suexec-pristine apache2-suexec-custom apache2-utils \
 && apt-get install -y libmcrypt-dev mcrypt \
 && apt-get install -y php5 libapache2-mod-php5 php5-mcrypt php-pear \
 && apt-get install -y php5-common php5-cli php5-curl php5-gmp php5-ldap php5-sqlite \
 && apt-get clean \
 && a2enmod headers

# if using TLS directly, i.e. without proxy:
#RUN apt-get install -y libapache2-mod-gnutls \
# && apt-get clean \
# && a2enmod gnutls

# save apache config for init_config script
RUN mkdir -p /opt/default/ && cp -pr /etc/apache2 /opt/default/ \
 && sed -ie 's/^Listen 80/Listen 8080/' /opt/default/apache2/ports.conf
COPY install/etc/apache2/conf-available/servername.conf /opt/default/apache2/conf-available/servername.conf
COPY install/etc/apache2/sites-enabled/000-default.conf /opt/default/apache2/sites-enabled/000-default.conf

# --- install postfix and save send-only config for init_config script
RUN apt-get install -y mailutils \
 && apt-get clean \
 && sed -ie 's/^inet_interfaces = all/inet_interfaces = loopback-only/' /etc/postfix/main.cf \
 && cp -pr /etc/postfix /opt/default/

# --- SimpleSAMLphp
# install core, tweak config
ENV SSP_ROOT=/var/simplesaml
RUN git clone https://github.com/simplesamlphp/simplesamlphp.git $SSP_ROOT \
 && touch /tmp/sqlitedatabase.sq3

# prepare default configuration to be copied into container volumes at run time
RUN mkdir -p $SSP_ROOT/attributemap-templates \
 && cp -pr $SSP_ROOT/attributemap/* $SSP_ROOT/attributemap-templates/ \
 && for module in cron metarefresh; do \
        cp -pr $SSP_ROOT/modules/${module}/config-templates/* $SSP_ROOT/config-templates/ \
        touch $SSP_ROOT/modules/${module}/enable \
    done
COPY install/etc/simplesaml/attributemap/pvp2name.php $SSP_ROOT/attributemap-templates/
COPY install/etc/simplesaml/config/*.php $SSP_ROOT/config-templates/
RUN mkdir -p /opt/default/www/html/test
COPY install/www/*.php /opt/default/www/html/test/


# --- PHP Composer
RUN echo "extension=mcrypt.so" >>  /etc/php5/mods-available/mcrypt.ini \
 && php5enmod mcrypt
WORKDIR $SSP_ROOT
RUN curl -sS https://getcomposer.org/installer | php \
 && php composer.phar install


# --- Scripts
COPY install/scripts/*.sh /
RUN chmod +x /*.sh


# --- Run non-root (with its uid mapping nicely to the docker host)
ARG USERNAME=ssphttpd
ARG UID=3000
RUN groupadd -g $UID $USERNAME \
 && adduser --gid $UID --no-create-home --disabled-password --gecos "" --uid $UID $USERNAME \
 && mkdir -p /opt && chmod 750 /opt \
 && chown $USERNAME:$USERNAME /var/run/apache2 /var/lock/apache2

USER $USERNAME

