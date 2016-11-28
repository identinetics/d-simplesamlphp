#!/bin/sh
# install drupal

# https://www.drupal.org/node/3060/release
DRUPAL_VERSION=7.52
DRUPAL_MD5=4963e68ca12918d3a3eae56054214191

curl -fSL "https://ftp.drupal.org/files/projects/drupal-${DRUPAL_VERSION}.tar.gz" -o drupal.tar.gz
echo "${DRUPAL_MD5} *drupal.tar.gz" | md5sum -c - 
tar -xz --strip-components=1 -f drupal.tar.gz 
rm drupal.tar.gz 
chown -R www-data:www-data sites


echo "install simpleSAMLphp_auth module"
SSPAUTH_VERSION=simplesamlphp_auth-7.x-2.0-alpha2.tar.gz
cd /var/www/html/sites/all/modules
wget https://ftp.drupal.org/files/projects/$SSPAUTH_VERSION
tar -xzf $SSPAUTH_VERSION 
rm $SSPAUTH_VERSION
chown -R 33:33 * 

