<html>
<head><title>Example Service Provider in PHP</title></head>
<body>
<h1>Example Service Provider in PHP</h1>
<p>Authenticated page</p>
<h2>Your attributes:</h2>
<pre>
<?php
 require_once('/var/simplesaml/lib/_autoload.php'); // init SSP
 $as = new SimpleSAML_Auth_Simple('default-sp');    // select the default authentication source
 $as->requireAuth();                                // require authentication
 $attributes = $as->getAttributes();
 print_r($attributes);                              // get the attributes (with OIDs)
 print_r('<h2>Your NameID:</h2>');
 print_r($as->getAuthData('saml:sp:NameID'));       // print the NameID
 print_r('<h2>Other Attributes:</h2>');
 if (array_key_exists('cn', $attributes)) {
     cn = $attributes['cn'][0];
     print_r('<p>Common Name: ' . $cn);
 };

?>
</pre>
</body>
</html>