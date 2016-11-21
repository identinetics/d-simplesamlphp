<?php

$config = array(

    #'conditionalGET'   => TRUE,

    'sets' => array(

        'testpvgvat' => array(
            'cron'      => array('hourly'),
            'sources'   => array(
                array(
                    #'blacklist' => array(),  # entityIDs that should be excluded from this src.
                    #'whitelist' => array(),

                    #'conditionalGET' => TRUE,
                    'src' => 'http://mdfeed.federation.org/metadata.xml',
                    'certificates' => array('/etc/pki/sign/certs/metadata_crt.pem',),
                    'types' => array('saml20-idp-remote', 'attributeauthority-remote'),
                ),
            ),
            'expireAfter'       => 60*60*24*10, // Maximum 10 days cache time
            'outputDir'     => 'metadata/metarefresh-testpvgvat/',
            'outputFormat' => 'serialize',
        ),
    ),
);



