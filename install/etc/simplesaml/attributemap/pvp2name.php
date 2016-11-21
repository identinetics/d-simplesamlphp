// PVP V2.1.2 attributes (https://www.ref.gv.at/fileadmin/user_upload/PVP2-AttributeProfile_2-1-2_20150601.pdf)
<?php
$attributemap = array(
    // core attributes
    'urn:oid:1.2.40.0.10.2.1.1.261.10'  => 'X-PVP-VERSION',
    'urn:oid:1.2.40.0.10.2.1.1.261.20'  => 'X-PVP-PRINCIPALNAME',
    'urn:oid:2.5.4.42'                  => 'X-PVP-GIVENNAME',
    'urn:oid:1.2.40.0.10.2.1.1.55'      => 'X-PVP-BIRTHDATE',
    'urn:oid:0.9.2342.19200300.100.1.1' => 'X-PVP-USERID',
    'urn:oid:1.2.40.0.10.2.1.1.1'       => 'X-PVP-GID',
    'urn:oid:1.2.40.0.10.2.1.1.149'     => 'X-PVP-BPK',
    'urn:oid:0.9.2342.19200300.100.1.3' => 'X-PVP-MAIL',
    'urn:oid:2.5.4.20'                  => 'X-PVP-TEL',
    'urn:oid:1.2.40.0.10.2.1.1.71'      => 'X-PVP-PARTICIPANT-ID',
    'urn:oid:1.2.40.0.10.2.1.1.261.24'  => 'X-PVP-PARTICIPANT-OKZ',
    'urn:oid:1.2.40.0.10.2.1.1.153'     => 'X-PVP-OU-OKZ',
    'urn:oid:1.2.40.0.10.2.1.1.3'       => 'X-PVP-OU-GV-OU-ID',
    'urn:oid:2.5.4.11'                  => 'X-PVP-OU',
    'urn:oid:1.2.40.0.10.2.1.1.33'      => 'X-PVP-FUNCTION',
    'urn:oid:1.2.40.0.10.2.1.1.261.30'  => 'X-PVP-ROLES',
    // charge extension
    'urn:oid:1.2.40.0.10.2.1.1.261.40'  => 'X-PVP-INVOICE-RECPT-ID',
    'urn:oid:1.2.40.0.10.2.1.1.261.50'  => 'X-PVP-COST-CENTER-ID',
    'urn:oid:1.2.40.0.10.2.1.1.261.60'  => 'X-PVP-CHARGE-CODE',
    // eID-specific attrbutes /citizen use case) not included
);
?>