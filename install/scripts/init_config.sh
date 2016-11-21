#!/bin/sh
# container entrypoint for initializing mounted volumes with default data

echo "initializing apache2 config"
cp -pr /opt/default/apache2 /etc/
a2enconf servername

echo "initializing postfix config"
cp -pr /opt/default/postfix /etc/

echo "Create Signing/Encryption Certificate in  $SSP_ROOT/cert/" # used for XMLDsig/XMLEnc
openssl req -x509 -batch -nodes -newkey rsa:2048 \
    -keyout $SSP_ROOT/cert/saml-key.pem \
    -out $SSP_ROOT/cert/saml-crt.pem

