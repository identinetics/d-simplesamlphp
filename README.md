# docker-simplesamlphp

simpleSAMLphp (SSP) Docker image


##Introduction

Install SSP. Plus:
- Immutable container, exposing config, log etc. to docker host volumes, with proper 
  initialization from default values
- Run container as non-root
- By default exclude TSL configuration (delegated to a dedicated proxy)
- Configure automated metadata source by default


## Prerequisites

  - Install [Docker](https://www.docker.com/)

## Install Docker Build Environment

    git clone https://github.com/rhoerbe/docker-simplesamlphp.git
    cd docker-simplesamlphp
    git submodule update --init && cd dscripts && git checkout master && cd ..
    cp conf.sh.default conf.sh
    
Modify conf.sh to your local needs, then:
    
    dscripts/build.sh    
    
## Configure SSP as an SAML2 SP

Create a default configuration:

    dscripts/run.sh -ir /init_config.sh

Now go thru the configuration steps for SSP and the IDP(s)

- Configure a reverse proxy (load balancer) terminating TLS to relay 
  requests on the dockernet interface providing the HTTP_X_FORWARDED headers
- Configure apache vhost (minimum: set ServerName to the external host 
  name matching HTTP_X_FORWARDED_HOST)
- Create the metadata for the SP and make it available to the IDPs 
  Download the XML file from https://<sp-fqdn>/simplesaml/module.php/saml/sp/metadata.php/default-sp
  Metadata created by SSP is minimal any might be compliant with the 
  federation requirements and have to be edited.
  Import into the federation's metadata aggregator (or the IDP for a 
  local installation). 
- Configure metadata feed for SSP (-> config/config-metarefresh.php)
- Configure config.php (https://simplesamlphp.org/docs/stable/simplesamlphp-install#section_7). 
  'baseurlpath' must be set to the https://HTTP_X_FORWARDED_HOST/simplesaml/
- Configure cron & metarefresh (https://simplesamlphp.org/docs/stable/simplesamlphp-automated_metadata)
- Optionally configure postfix to forward mail from root to an accout on a smart host (/etc/postfix ist mapped to the docker host)

# Run

    dscripts/run.sh 

To access the SSP admin page from the host server try:

    https://<sp-fqdn>/simplesaml

    username: admin
    password: <whateveryoudefinedbeforeanddeemedsecureenough>

To access SP pages try:
    https://<sp-fqdn>/test.php   # unauthenticated
    https://<sp-fqdn>/hellosaml.php   # authenticated

## Troubleshooting

start with the apache logs (/var/log/apache2

## Session Handling
-> Extend SP phpsession, or avoid SSP phpsession


### References

[simpleSAMLphp Installation and Configuration](https://simplesamlphp.org/docs/stable/simplesamlphp-install)

[How To Install Linux, Apache, MySQL, PHP (LAMP) stack on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu)

