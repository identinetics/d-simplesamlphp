#!/bin/sh
# container entrypoint for initializing mounted volumes with default data

echo "initializing apache2 config & test scripts in content root"
cp -pr /opt/default/apache2 /etc/
a2enconf servername
cp -pr /opt/default/www/* /var/www/

echo "initializing postfix config"
cp -pr /opt/default/postfix /etc/

echo "initializing attributemap/, config/ and metadata/ with default data"
cp -pr $SSP_ROOT/attributemap-templates/* $SSP_ROOT/attributemap/
cp -p  $SSP_ROOT/config-templates/* $SSP_ROOT/config/
cp -pr $SSP_ROOT/metadata-templates/* $SSP_ROOT/metadata/
for module in cron metarefresh; do
    cp -pr $SSP_ROOT/modules/${module}/config-templates/* $SSP_ROOT/config/
    touch $SSP_ROOT/modules/${module}/enable
done
cp -p  $SSP_ROOT/config-templates/config-metarefresh.php $SSP_ROOT/config/   # overwrite default template
perl -i -pe "s{^(\s*)'logging.handler'\s+=> 'syslog'}{$1'logging.handler'\s+=> 'file'}" $SSP_ROOT/config/config.php
perl -i -pe "s{^(\s*)array('type' => 'flatfile')}{$1array('type' => 'serialize', 'directory' => 'metadata\/metarefresh-federation'),}" $SSP_ROOT/config/config.php

echo "Create Signing/Encryption Certificate in  $SSP_ROOT/cert/" # used for XMLDsig/XMLEnc
openssl req -x509 -batch -nodes -newkey rsa:2048 \
    -keyout $SSP_ROOT/cert/saml-key.pem \
    -out $SSP_ROOT/cert/saml-crt.pem

echo "Created default configuration for https://sp.example.com"
