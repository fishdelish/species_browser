<?xml version="1.0" encoding="UTF-8"?>
<!-- XSL stylesheet that transforms the results of a particular SPARQL query to XHTML. Note that this is tailored pretty specifically to the results from a particular query. -->

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:sparql="http://www.w3.org/2005/sparql-results#">

<xsl:strip-space elements="*" />
<xsl:preserve-space elements="sparql:literal" />
<xsl:output method="xml" 
  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
  doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes"/>


<xsl:template match="sparql:sparql">
<!-- We're assuming that we have only one result, and that results has
     a number of bindings, so we can just use variables to handle them
     all and can set up the variables once. This may not be a good
     assumption if we start to do more complicated things.  -->

<xsl:variable name="common" select="sparql:results/sparql:result[1]/sparql:binding[@name='common']"/>
<xsl:variable name="genus" select="sparql:results/sparql:result[1]/sparql:binding[@name='genus']"/>
<xsl:variable name="species" select="sparql:results/sparql:result[1]/sparql:binding[@name='species']"/>
<xsl:variable name="family" select="sparql:results/sparql:result[1]/sparql:binding[@name='family']"/>
<xsl:variable name="subfamily" select="sparql:results/sparql:result[1]/sparql:binding[@name='subfamily']"/>
<xsl:variable name="order" select="sparql:results/sparql:result[1]/sparql:binding[@name='order']"/>
<xsl:variable name="class" select="sparql:results/sparql:result[1]/sparql:binding[@name='class']"/>
<xsl:variable name="author" select="sparql:results/sparql:result[1]/sparql:binding[@name='author']"/>
<xsl:variable name="length" select="sparql:results/sparql:result[1]/sparql:binding[@name='length']"/>
<xsl:variable name="commonlength" select="sparql:results/sparql:result[1]/sparql:binding[@name='commonlength']"/>
<xsl:variable name="biology" select="sparql:results/sparql:result[1]/sparql:binding[@name='biology']"/>
<xsl:variable name="pic" select="sparql:results/sparql:result[1]/sparql:binding[@name='pic']"/>
<xsl:variable name="distribution" select="sparql:results/sparql:result[1]/sparql:binding[@name='distribution']"/>
<xsl:variable name="description" select="sparql:results/sparql:result[1]/sparql:binding[@name='description']"/>
<xsl:variable name="demerspelag" select="sparql:results/sparql:result[1]/sparql:binding[@name='demerspelag']"/>
<xsl:variable name="anacat" select="sparql:results/sparql:result[1]/sparql:binding[@name='anacat']"/>
<xsl:variable name="depthshallow" select="sparql:results/sparql:result[1]/sparql:binding[@name='depthshallow']"/>
<xsl:variable name="depthdeep" select="sparql:results/sparql:result[1]/sparql:binding[@name='depthdeep']"/>
<xsl:variable name="depthcommondeep" select="sparql:results/sparql:result[1]/sparql:binding[@name='depthcommondeep']"/>
<xsl:variable name="danger" select="sparql:results/sparql:result[1]/sparql:binding[@name='danger']"/>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
       <link rel="stylesheet" type="text/css" media="screen" href="style.css"/>
       <title>FishDelish Species</title>
    </head>
    <body>
<div id="content">
  <xsl:apply-templates select="sparql:results"/>
</div>
<div id="footer">
  <a href="http://fishdelish.cs.man.ac.uk">FishDelish</a> Project, 2011, using information provided by <a href="http://www.fishbase.org">Fishbase</a>.
</div>
    </body>
</html>
</xsl:template>

<xsl:template match="sparql:results"  xmlns="http://www.w3.org/1999/xhtml">
  <h1>Species List</h1>
  <p><xsl:value-of select="count(sparql:result)"/><xsl:text> species</xsl:text></p>
  <ul>
    <xsl:for-each select="sparql:result">
      <li><a><xsl:attribute name="href">species.php?uri=<xsl:value-of select="sparql:binding[@name='uri']"/></xsl:attribute><em><xsl:value-of select="sparql:binding[@name='genus']"/><xsl:text> </xsl:text><xsl:value-of select="sparql:binding[@name='species']"/></em></a>
      <xsl:if test="sparql:binding[@name='common'] != ''">
	<xsl:text> (</xsl:text><xsl:value-of select="sparql:binding[@name='common']"/><xsl:text>)</xsl:text>
      </xsl:if></li>
    </xsl:for-each>
  </ul>
</xsl:template>

<xsl:template match="*">
</xsl:template>
</xsl:stylesheet>
