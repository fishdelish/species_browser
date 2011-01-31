<?php 
include("rap.php");
include("functions.php");

header("Content-Type: application/xml");

/* Execute the SPARQL Query and get a DOMDocument object as a response. */
$xml = sparqlQueryXML( ALL_FAMILIES_QUERY ); 

/* Add a processing instruction that pulls in the stylesheet */

$xslt = $xml->createProcessingInstruction('xml-stylesheet', 'type="text/xsl" href="allfamilies.xsl"');
$xml->insertBefore($xslt,$xml->documentElement);

/* Return the resulting XML */

echo $xml->saveXML();

?>
