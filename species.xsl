<?xml version="1.0" encoding="UTF-8"?>
<!-- XSL stylesheet that transforms the results of a particular SPARQL query to XHTML. Note that this is tailored pretty specifically to the results from a particular query. -->

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:sparql="http://www.w3.org/2005/sparql-results#">

<xsl:strip-space elements="*" />
<xsl:preserve-space elements="sparql:literal" />
<xsl:output method="html" indent="yes"/>


<xsl:template match="sparql:sparql">

<!-- We're assuming that we have only one result, and that results has
     a number of bindings, so we can just use variables to handle them
     all and can set up the variables once. This may not be a good
     assumption if we start to do more complicated things.  -->

<xsl:variable name="common" select="sparql:results/sparql:result[1]/sparql:binding[@name='common']"/>
<xsl:variable name="genus" select="sparql:results/sparql:result[1]/sparql:binding[@name='genus']"/>
<xsl:variable name="code" select="sparql:results/sparql:result[1]/sparql:binding[@name='code']"/>
<xsl:variable name="species" select="sparql:results/sparql:result[1]/sparql:binding[@name='species']"/>
<xsl:variable name="subfamily" select="sparql:results/sparql:result[1]/sparql:binding[@name='subfamily']"/>
<xsl:variable name="author" select="sparql:results/sparql:result[1]/sparql:binding[@name='author']"/>
<xsl:variable name="biology" select="sparql:results/sparql:result[1]/sparql:binding[@name='biology']"/>
<xsl:variable name="distribution" select="sparql:results/sparql:result[1]/sparql:binding[@name='distribution']"/>
<xsl:variable name="iucnCode" select="sparql:results/sparql:result[1]/sparql:binding[@name='iucnCode']"/>
<xsl:variable name="iucnAssessment" select="sparql:results/sparql:result[1]/sparql:binding[@name='iucnAssessment']"/>
<xsl:variable name="demerspelag" select="sparql:results/sparql:result[1]/sparql:binding[@name='demerspelag']"/>
<xsl:variable name="anacat" select="sparql:results/sparql:result[1]/sparql:binding[@name='anacat']"/>
<xsl:variable name="depthshallow" select="sparql:results/sparql:result[1]/sparql:binding[@name='depthshallow']"/>
<xsl:variable name="depthdeep" select="sparql:results/sparql:result[1]/sparql:binding[@name='depthdeep']"/>
<xsl:variable name="depthcommondeep" select="sparql:results/sparql:result[1]/sparql:binding[@name='depthcommondeep']"/>
<xsl:variable name="length" select="sparql:results/sparql:result[1]/sparql:binding[@name='length']"/>
<xsl:variable name="commonlength" select="sparql:results/sparql:result[1]/sparql:binding[@name='commonlength']"/>
<xsl:variable name="family" select="sparql:results/sparql:result[1]/sparql:binding[@name='family']"/>
<xsl:variable name="order" select="sparql:results/sparql:result[1]/sparql:binding[@name='order']"/>
<xsl:variable name="class" select="sparql:results/sparql:result[1]/sparql:binding[@name='class']"/>
<xsl:variable name="description" select="sparql:results/sparql:result[1]/sparql:binding[@name='description']"/>
<xsl:variable name="danger" select="sparql:results/sparql:result[1]/sparql:binding[@name='danger']"/>
<xsl:variable name="pic" select="sparql:results/sparql:result[1]/sparql:binding[@name='pic']"/>
<xsl:variable name="refAuthor" select="sparql:results/sparql:result[1]/sparql:binding[@name='refno']"/>
<xsl:variable name="refNo" select="sparql:results/sparql:result[1]/sparql:binding[@name='refauthor']"/>
<xsl:variable name="refDate" select="sparql:results/sparql:result[1]/sparql:binding[@name='refyear']"/>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
       <link rel="stylesheet" type="text/css" media="screen" href="style.css"/>
       <title>
	 Species: <xsl:value-of select="$genus"/><xsl:text> </xsl:text>
         <xsl:value-of select="$species"/>
       </title>
    </head>
    <body>
<div id="content">
  <!--
      QUESTION: How do we get at the references for use in external sources? 
	<div class="externals">
	  Catalog of Fishes: (<a href="http://research.calacademy.org/research/ichthyology/catalog/fishcatget.asp?tbl=genus&amp;genid=5542">genus</a>, <a href="http://research.calacademy.org/research/ichthyology/catalog/fishcatget.asp?tbl=species&amp;spid=25893">species</a>) | <a href="http://www.itis.gov/servlet/SingleRpt/SingleRpt?search_topic=TSN&amp;search_value=642242">ITIS</a> | <a href="http://www.catalogueoflife.org/search_results.php?search_string=Siphamia+mossambica&amp;match_whole_words=on">CoL</a>
	</div>
-->
        <xsl:if test="$pic">
        <div class="picture">
	  <!-- Horrible hack to determine the file type of the thumbnail -->
	  <xsl:variable name="imagetype">
	  <xsl:if test="contains($pic,'.jpg')">jpg</xsl:if>
	  <xsl:if test="contains($pic,'.gif')">gif</xsl:if>
	  </xsl:variable>
	  <!-- end Horrible Hack -->
	  <img class="thumb"><xsl:attribute name="src">http://www.fishbase.org/images/thumbnails/<xsl:value-of select="$imagetype"/>/tn_<xsl:value-of select="$pic"/></xsl:attribute><xsl:attribute name="alt"><xsl:value-of select="$common"/></xsl:attribute></img>
	<div class="caption"><xsl:value-of select="$genus"/><xsl:text> </xsl:text>
         <xsl:value-of select="$species"/>
	</div>
        </div>
	</xsl:if>
        <div class="name">
            <div class="scientific"><xsl:value-of select="$genus"/><xsl:text> </xsl:text>
         <xsl:value-of select="$species"/></div>
            <div class="author"><xsl:value-of select="$author"/></div>
            <div class="common"><xsl:value-of select="$common"/></div>
        </div>
       <div class="details detail">
	   <div class="category">Classification</div>
	   <div class="value">
	     <xsl:value-of select="$class"/> | 
	     <a><xsl:attribute name="href">order.php?uri=http://fishdelish.cs.man.ac.uk/rdf/orders/<xsl:value-of select="$order"/></xsl:attribute><xsl:value-of select="$order"/></a> |
	     <a><xsl:attribute name="href">family.php?uri=http://fishdelish.cs.man.ac.uk/rdf/families/<xsl:value-of select="$family"/></xsl:attribute><xsl:value-of select="$family"/></a> 
	   <xsl:if test="$subfamily">
	     | <xsl:value-of select="$subfamily"/>
	   </xsl:if>
	   </div>
	</div>
        <div class="details">
            <div class="detail">
                <div class="category">Main Reference</div>
                <div class="value"><a><xsl:attribute name="href">http://fishbase.org/references/FBRefSummary.php?ID=<xsl:value-of select="$refno"/></xsl:attribute><xsl:value-of select="$refauthor"/>, <xsl:value-of select="$refdate" /></a></div>
            </div>
            <div class="detail">
                <div class="category">Size</div>
                <div class="value"><xsl:if test="$length">Max length: <xsl:value-of select="$length"/>cm; </xsl:if><xsl:if test="$commonlength">common length: <xsl:value-of select="$commonlength"/>cm</xsl:if></div>
            </div>
            <div class="detail">
                <div class="category">Environment</div>
                <div class="value">
		<xsl:if test="$demerspelag">
		  <xsl:value-of select="$demerspelag"/>; 
		</xsl:if>
		<xsl:if test="$anacat">
		  <xsl:value-of select="$anacat"/>;
		</xsl:if>
		<xsl:if test="$depthshallow">
		  depth range <xsl:value-of select="$depthshallow"/>-<xsl:value-of select="$depthdeep"/>m, commonly <xsl:value-of select="$depthshallow"/>-<xsl:value-of select="$depthcommondeep"/>m
                </xsl:if>
</div>
            </div>
	    <!--
            <div class="detail">
                <div class="category">Climate/Range</div>
                <div class="value">climate/range</div>
            </div>
	    -->
            <div class="detail">
                <div class="category">Distribution</div>
                <div class="value"><xsl:value-of select="$distribution" disable-output-escaping="yes"/></div>
            </div>
	    <!-- Issue: This information contains HTML markup. Need to handle that properly -->
            <div class="detail">
                <div class="category">Short Description</div>
                <div class="value"><xsl:value-of select="$description" disable-output-escaping="yes"/></div>
            </div>
            <div class="detail">
                <div class="category">Biology</div>
                <div class="value"><xsl:value-of select="$biology" disable-output-escaping="yes"/></div>
            </div>
            <div class="detail">
                <div class="category">IUCN Red List Status</div>
		<xsl:if test="$iucnCode">
		  <div class="value">
		    <span class="iucn">
			<xsl:choose>
			  <xsl:when test="$iucnCode = 'EX'"><span class="ex">Extinct</span></xsl:when>
			  <xsl:when test="$iucnCode = 'EW'"><span class="ew">Extinct in the Wild</span></xsl:when>
			  <xsl:when test="$iucnCode = 'CE'"><span class="ce">Critically Endangered</span></xsl:when>
			  <xsl:when test="$iucnCode = 'CR'"><span class="ce">Critically Endangered (CR)</span></xsl:when>
			  <xsl:when test="$iucnCode = 'NT'"><span class="nt">Near Threatened</span></xsl:when>
			  <xsl:when test="$iucnCode = 'EN'"><span class="en">Endangered</span></xsl:when>
			  <xsl:when test="$iucnCode = 'VU'"><span class="vu">Vulnerable</span></xsl:when>
			  <xsl:when test="$iucnCode = 'LR'"><span class="lr">Lower Risk</span></xsl:when>
			  <xsl:when test="$iucnCode = 'LR/lc'"><span class="lr">Lower Risk</span></xsl:when>
			  <xsl:when test="$iucnCode = 'LR/nt'"><span class="lr">Lower Risk</span></xsl:when>
			  <xsl:when test="$iucnCode = 'LR/cd'"><span class="lr">Lower Risk</span></xsl:when>
			  <xsl:when test="$iucnCode = 'LC'"><span class="lc">Least Concern</span></xsl:when>
			  <xsl:when test="$iucnCode = 'DD'"><span class="dd">Data Deficient</span></xsl:when>
			  <xsl:when test="$iucnCode = 'NE'"><span class="ne">Not Evaluated</span></xsl:when>
			  <xsl:when test="$iucnCode = 'N.E.'"><span class="ne">Not Evaluated</span></xsl:when>
			  <xsl:otherwise><xsl:value-of select="$iucnCode"/></xsl:otherwise>
			</xsl:choose>
		    </span>
		  <xsl:if test="$iucnAssessment"><xsl:text> [</xsl:text>
		  <xsl:value-of select="$iucnAssessment" disable-output-escaping="yes"/><xsl:text>]</xsl:text>
		  </xsl:if>
		  </div>
                </xsl:if>
            </div>
            <div class="detail">
                <div class="category">Threat to Humans</div>
                <div class="value"><xsl:value-of select="$danger"/></div>
            </div>
        </div>
	<div class="fblink">
	  <a><xsl:attribute name="href">http://www.fishbase.org/Summary/SpeciesSummary.php?ID=<xsl:value-of select="$code"/></xsl:attribute>FishBase page</a> 
	</div>
	</div>
	<div id="footer">
	  <a href="http://fishdelish.cs.man.ac.uk">FishDelish</a> Project, (c) <a href="http://www.fishbase.org">Fishbase</a>, January 2011.
	</div>
    </body>
</html>
</xsl:template>

<xsl:template match="sparql:binding[@name='genus']">
  Genus: <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="sparql:binding[@name='species']">
  Species: <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="*">
</xsl:template>
</xsl:stylesheet>
