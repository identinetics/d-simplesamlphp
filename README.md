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

## Build & configure & run

    git clone https://github.com/rhoerbe/docker-simplesamlphp.git

Modify conf.sh to your local needs, then:

``` bash
dscripts/build.sh
dscripts/run.sh -ir /init_config.sh
```

Configure apache and SSP config.
Configure a reverse proxy (load balancer) terminating TLS to relay requests
on the dockernet interface, then run:

    dscripts/run.sh 

To access simpleSAMLphp from the host server:

    http://localhost:50081/simplesaml/

    username: admin
    password: password


### References

[simpleSAMLphp Installation and Configuration](https://simplesamlphp.org/docs/stable/simplesamlphp-install)

[How To Install Linux, Apache, MySQL, PHP (LAMP) stack on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu)

