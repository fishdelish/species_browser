<?php
define("SPARQL_ENDPOINT", "http://fishdelish.cs.man.ac.uk/sparql/");
define("SPECIES_QUERY", "
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX fish: <http://fishdelish.cs.man.ac.uk/rdf/vocab/resource/>

SELECT ?common ?code ?genus ?species ?subfamily 
       ?author ?refno ?refauthor ?refyear ?biology ?distribution 
       ?iucnCode ?iucnAssessment
       ?demerspelag ?anacat
       ?depthshallow ?depthdeep ?depthcommondeep 
       ?length ?commonlength 
       ?family ?order ?class
       ?description 
       ?danger
       ?pic

WHERE {
 %URI% fish:species_Genus ?genus.
 %URI% fish:species_SpecCode ?code.
 %URI% fish:species_Species ?species.
 OPTIONAL {%URI% fish:species_Author ?author}.
 OPTIONAL {%URI% fish:species_FBname ?common}.
 OPTIONAL {%URI% fish:species_SpeciesRefNo ?refno}.
 OPTIONAL {?ref fish:refrens_RefNo ?refno}.
 OPTIONAL {?ref fish:refrens_Author ?refauthor}.
 OPTIONAL {?ref fish:refrens_Year ?refyear}.
 OPTIONAL {%URI% fish:species_Subfamily ?subfamily.}
 OPTIONAL {%URI% fish:species_Comments ?biology.}
 OPTIONAL {?stocks fish:stocks_SpecCode %URI%.
           ?stocks fish:stocks_StockDefs ?distribution.}
 OPTIONAL {?stocks fish:stocks_SpecCode %URI%.
           ?stocks fish:stocks_IUCN_Code ?iucnCode.}
 OPTIONAL {?stocks fish:stocks_SpecCode %URI%.
           ?stocks fish:stocks_IUCN_Assessment ?iucnAssessment.}
 OPTIONAL {%URI% fish:species_DepthRangeShallow ?depthshallow.
 %URI% fish:species_DepthRangeDeep ?depthdeep.
 %URI% fish:species_DepthRangeComDeep ?depthcommondeep.
 %URI% fish:species_Length ?length.
 %URI% fish:species_CommonLength ?commonlength.
 }
 OPTIONAL {
 %URI% fish:species_FamCode ?famcode.
 ?famcode fish:families_Family ?family. 
 ?famcode fish:families_Order ?order.
 ?famcode fish:families_Class ?class.
 }
 
 OPTIONAL {?morph fish:morphdat_Speccode %URI%.
 ?morph fish:morphdat_AddChars ?description.}
 OPTIONAL {%URI% fish:species_DemersPelag ?demerspelag.}
 OPTIONAL {%URI% fish:species_AnaCat ?anacat.}
 OPTIONAL {%URI% fish:species_PicPreferredName ?pic.}
 OPTIONAL {%URI% fish:species_Dangerous ?danger.}

}
");

define("FAMILY_QUERY", "
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX fish: <http://fishdelish.cs.man.ac.uk/rdf/vocab/resource/>

SELECT ?family ?code ?common ?order ?class ?remark ?division
    ?activity ?etymology ?marine 
    ?pic ?fresh ?brackish ?species ?specGenus ?specSpecies

WHERE {
 %URI% fish:families_Family ?family.
 %URI% fish:families_FamCode ?code.
 %URI% fish:families_Order ?order.
 %URI% fish:families_Class ?class.
 OPTIONAL {%URI% fish:families_CommonName ?common.}
 OPTIONAL {%URI% fish:families_Remark ?remark.}
 OPTIONAL {%URI% fish:families_Activity ?activity.}
 OPTIONAL {%URI% fish:families_Division ?division.}
 OPTIONAL {%URI% fish:families_Etymology ?etymology.}
 OPTIONAL {%URI% fish:families_Freshwater ?fresh.}
 OPTIONAL {%URI% fish:families_Brackish ?brackish.}
 OPTIONAL {%URI% fish:families_Marine ?marine.}
 OPTIONAL {%URI% fish:families_FamPic ?pic.}
 OPTIONAL {?species fish:species_FamCode %URI%.
           ?species fish:species_Genus ?specGenus.
           ?species fish:species_Species ?specSpecies.}
}
ORDER BY ASC(?specGenus) ASC(?specSpecies)
");

define("ORDER_QUERY", "
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX fish: <http://fishdelish.cs.man.ac.uk/rdf/vocab/resource/>

SELECT ?common ?order ?class ?remark ?etymology ?classetymology ?family ?famFamily

WHERE {
 %URI% fish:orders_Order ?order.
 %URI% fish:orders_Class ?class.
 OPTIONAL {%URI% fish:orders_CommonName ?common.}
 OPTIONAL {%URI% fish:orders_Remark ?remark.}
 OPTIONAL {%URI% fish:orders_EtymologyOrder ?etymology.}
 OPTIONAL {%URI% fish:orders_EtymologyClass ?classetymology.}
 OPTIONAL {?family fish:families_Order ?order.
           ?family fish:families_Family ?famFamily.}
}
ORDER BY ASC(?famFamily)
");

define("ALL_SPECIES_QUERY","
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX fish: <http://fishdelish.cs.man.ac.uk/rdf/vocab/resource/>

SELECT ?uri ?genus ?species ?common

WHERE {
 ?uri rdf:type fish:species.     
   ?uri fish:species_Genus ?genus.
   ?uri fish:species_Species ?species.
   OPTIONAL {?uri fish:species_FBname ?common.}
}

ORDER BY ASC(?genus) ASC(?species)
");

define("ALL_ORDERS_QUERY","
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX fish: <http://fishdelish.cs.man.ac.uk/rdf/vocab/resource/>

SELECT ?uri ?order ?common

WHERE {
 ?uri rdf:type fish:orders.     
   ?uri fish:orders_Order ?order.
   ?uri fish:orders_CommonName ?common.
}

ORDER BY ASC(?order)
");

define("ALL_FAMILIES_QUERY","
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX fish: <http://fishdelish.cs.man.ac.uk/rdf/vocab/resource/>

SELECT ?uri ?family ?common

WHERE {
 ?uri rdf:type fish:families.     
   ?uri fish:families_Family ?family.
   ?uri fish:families_CommonName ?common.
}

ORDER BY ASC(?family)
");


?>
