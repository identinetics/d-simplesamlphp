<?php
 require_once('/var/simplesaml/lib/_autoload.php');
 $as = new SimpleSAML_Auth_Simple('default-sp');
 $as->requireAuth();
 $attributes = $as->getAttributes();
?>
<html>
<head><title>My First Service Provider in PHP</title></head>
<body>
<h1>My First SP</h1>
<p>Hello world!</p>
<h2>Your attributes:</h2>
<pre><?php print_r($attributes); ?></pre>
</body>
</html>