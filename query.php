<?php 
include("rap.php");
include("functions.php");

header("Content-Type: text/plain");

$query = SPECIES_QUERY;

if ($_GET['uri']) {
  $query = str_replace('%URI%', '<'.$_GET['uri'].'>', SPECIES_QUERY);
}
echo $query;

?>
