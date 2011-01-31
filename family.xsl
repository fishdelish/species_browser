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

<xsl:variable name="family" select="sparql:results/sparql:result[1]/sparql:binding[@name='family']"/>
<xsl:variable name="code" select="sparql:results/sparql:result[1]/sparql:binding[@name='code']"/>
<xsl:variable name="common" select="sparql:results/sparql:result[1]/sparql:binding[@name='common']"/>
<xsl:variable name="order" select="sparql:results/sparql:result[1]/sparql:binding[@name='order']"/>
<xsl:variable name="class" select="sparql:results/sparql:result[1]/sparql:binding[@name='class']"/>
<xsl:variable name="remark" select="sparql:results/sparql:result[1]/sparql:binding[@name='remark']"/>
<xsl:variable name="division" select="sparql:results/sparql:result[1]/sparql:binding[@name='division']"/>
<xsl:variable name="activity" select="sparql:results/sparql:result[1]/sparql:binding[@name='activity']"/>
<xsl:variable name="etymology" select="sparql:results/sparql:result[1]/sparql:binding[@name='etymology']"/>
<xsl:variable name="marine" select="sparql:results/sparql:result[1]/sparql:binding[@name='marine']"/>
<xsl:variable name="fresh" select="sparql:results/sparql:result[1]/sparql:binding[@name='fresh']"/>
<xsl:variable name="brackish" select="sparql:results/sparql:result[1]/sparql:binding[@name='brackish']"/>
<xsl:variable name="pic" select="sparql:results/sparql:result[1]/sparql:binding[@name='pic']"/>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
       <link rel="stylesheet" type="text/css" media="screen" href="style.css"/>
       <title>
	 <xsl:text>Family: </xsl:text><xsl:value-of select="$family"/>
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
	  <img class="thumb"><xsl:attribute name="src">http://www.fishbase.org/images/thumbnails/gif/tn_<xsl:value-of select="$pic"/>.gif</xsl:attribute><xsl:attribute name="alt"><xsl:value-of select="$common"/></xsl:attribute></img>
	<div class="caption"><xsl:value-of select="$family"/>
	</div>
        </div>
	</xsl:if>
        <div class="name">
            <div class="scientific"><xsl:text>Family </xsl:text><xsl:value-of select="$family"/></div>
            <div class="common"><xsl:value-of select="$common"/></div>
        </div>
	<div class="details">
	  <div class="detail">
	    <div class="category">Order</div>
	    <div class="value">
	      <a><xsl:attribute name="href">order.php?uri=http://fishdelish.cs.man.ac.uk/rdf/orders/<xsl:value-of select="$order"/></xsl:attribute><xsl:value-of select="$order"/></a> 
	    </div>
	    <div class="category">Class</div>
	    <div class="value">
	      <xsl:value-of select="$class"/> 
	    </div>
	    <div class="category">Environment</div>
	    <div class="value">
              <strong>Fresh: </strong><xsl:choose><xsl:when test="$fresh='true'">Yes</xsl:when><xsl:otherwise>No</xsl:otherwise></xsl:choose> 
              <strong> | Brackish: </strong><xsl:choose><xsl:when test="$brackish='true'">Yes</xsl:when><xsl:otherwise>No</xsl:otherwise></xsl:choose> 
              <strong> | Marine: </strong><xsl:choose><xsl:when test="$marine='true'">Yes</xsl:when><xsl:otherwise>No</xsl:otherwise></xsl:choose> 
	    </div>
	    <div class="category">Etymology</div>
	    <div class="value">
	      <xsl:value-of select="$etymology"/> 
	    </div>
	    <div class="category">Remark</div>
	    <div class="value">
	      <xsl:value-of select="$remark" disable-output-escaping="yes"/> 
	    </div>
	    <div class="category">Division</div>
	    <div class="value">
	      <xsl:value-of select="$division"/> 
	    </div>
	    <div class="category">Typical Activity Level</div>
	    <div class="value">
	      <xsl:value-of select="$activity"/> 
	    </div>
	    <div class="category">Species</div>
	    <div class="value">
	      <xsl:for-each select="sparql:results/sparql:result">
		<a><xsl:attribute name="href">species.php?uri=<xsl:value-of select="sparql:binding[@name='species']"/></xsl:attribute><xsl:value-of select="sparql:binding[@name='specGenus']"/><xsl:text> </xsl:text>
		<xsl:value-of select="sparql:binding[@name='specSpecies']"/></a><xsl:text> </xsl:text>

	      </xsl:for-each>
	    </div>
	  </div>
	</div>
	<div class="fblink">
	  <a><xsl:attribute name="href">http://www.fishbase.org/Summary/FamilySummary.php?ID=<xsl:value-of select="$code"/></xsl:attribute>FishBase page</a> 
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
