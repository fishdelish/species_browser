<?php 
include("rap.php");
include("definitions.php");

/* Formats:

verbose (default): Lots of information
brief: some information
terse: basically link and name

*/

/* Run a SPARQL Query */
function sparqlQuery( $queryString ) {
  $client = ModelFactory::getSparqlClient(SPARQL_ENDPOINT);
  $client->setOutputFormat("xml");
  $query = new ClientQuery();
  $query->query($queryString);
  $result = $client->query($query);
  return $result;
}


/* Query requesting XML output */
function sparqlQueryXML( $queryString ) {
  $client = ModelFactory::getSparqlClient(SPARQL_ENDPOINT);
  $client->setOutputFormat("xml");;
  $query = new ClientQuery();
  $query->query($queryString);
  $result = $client->query($query);
  $doc = new DOMDocument();
  $doc->loadXML( $result );
  return $doc;
  /*   return SPARQLResultNodeToArray($doc);*/
}

/* Dodgy function mapping SPARQL queries... */
function SPARQLResultNodeToArray( $doc ) {
  $array = array();
  $results = $doc->getElementsByTagName("result");
  foreach ($results as $result) {
    $bindings = $result->getElementsByTagName("binding");
    $bindingArray = array();
    foreach ($bindings as $binding) {
      $key = "?".$binding->getAttribute("name");
      $literals = $binding->getElementsByTagName("literal");
      if ($literals->length > 0) {
 	$bindingArray[$key] = new Literal($literals->item(0)->nodeValue);
      } 
      $uris = $binding->getElementsByTagName("uri");
      if ($uris->length > 0) {
 	$bindingArray[$key] = new Resource($uris->item(0)->nodeValue);
      } 
    }
    $array[] = $bindingArray;
  }
  return $array;
}

?>