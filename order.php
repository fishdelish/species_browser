<?php 
include("rap.php");
include("functions.php");

header("Content-Type: application/xml");

$uri = $_GET['uri'];

$sparqlQueryToExecute = str_replace('%URI%', '<'.$uri.'>', ORDER_QUERY);

/* Execute the SPARQL Query and get a DOMDocument object as a response. */
$xml = sparqlQueryXML( $sparqlQueryToExecute ); 

/* Add a processing instruction that pulls in the stylesheet */

$xslt = $xml->createProcessingInstruction('xml-stylesheet', 'type="text/xsl" href="order.xsl"');
$xml->insertBefore($xslt,$xml->documentElement);

/* Return the resulting XML */

echo $xml->saveXML();

?>
