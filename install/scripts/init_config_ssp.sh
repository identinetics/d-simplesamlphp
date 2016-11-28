#!/bin/sh
# initialize mounted volumes with default data

echo "initializing apache2 config & test scripts in content root"
cp -pr /opt/default/apache2 /etc/
a2enconf servername
cp -pr /opt/default/www/* /var/www/


echo "initializing postfix config"
cp -pr /opt/default/postfix /etc/


echo "initializing attributemap/, config/ and metadata/ with default data"
cp -pr $SSP_ROOT/attributemap-templates/* $SSP_ROOT/attributemap/
cp -pr $SSP_ROOT/metadata-templates/* $SSP_ROOT/metadata/
mkdir -p /var/simplesaml/metadata/metarefresh-federation
chown 33:33 /var/simplesaml/metadata/metarefresh-federation
cp -p  $SSP_ROOT/config-templates/* $SSP_ROOT/config/

# set default logging to file
perl -i -pe "s{^(\s*)'logging.handler'\s+=> 'syslog'}{\1'logging.handler' => 'file'}" $SSP_ROOT/config/config.php
# set location for federated metadata
perl -i -pe "s{^(\s*)array\('type'\s+=> 'flatfile'\),}{\1array('type' => 'serialize', 'directory' => 'metadata\/metarefresh-federation'),}" $SSP_ROOT/config/config.php
# set store-type to sql
perl -i -pe "s{^(\s*)'store.type'\s+=> 'phpsession',}{\1'store.type' => 'sql',}" $SSP_ROOT/config/config.php
# set default session db
perl -i -pe "s{'sqlite:/path/to/sqlitedatabase.sq3'}{'sqlite:/tmp/sqlitedatabase.sq3'}" $SSP_ROOT/config/config.php


echo "Create Signing/Encryption Certificate in  $SSP_ROOT/cert/" # used for XMLDsig/XMLEnc
openssl req -x509 -batch -nodes -newkey rsa:2048 \
    -keyout $SSP_ROOT/cert/saml-key.pem \
    -out $SSP_ROOT/cert/saml-crt.pem

echo "Created default configuration for https://sp.example.com"
