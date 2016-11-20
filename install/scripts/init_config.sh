#!/bin/sh
# container entrypoint for initializing mounted volumes with default data

echo "initializing apache2 config"
cp -pr /opt/default/apache2 /etc/
a2enconf servername

echo "initializing postfix config"
cp -pr /opt/default/postfix /etc/

echo "initializing $SSP_ROOT/config/ and $SSP_ROOT/metadata/ with default data"

cp -pr $SSP_DEFAULTCONF/config/* $SSP_ROOT/config/
cp -pr $SSP_DEFAULTCONF/metadata/* $SSP_ROOT/metadata/

echo "Create Signing/Encryption Certificate in  $SSP_ROOT/cert/" # used for XMLDsig/XMLEnc
openssl req -x509 -batch -nodes -newkey rsa:2048 \
    -keyout $SSP_ROOT/cert/saml-key.pem \
    -out $SSP_ROOT/cert/saml-crt.pem

