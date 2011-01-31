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
<xsl:variable name="order" select="sparql:results/sparql:result[1]/sparql:binding[@name='order']"/>
<xsl:variable name="class" select="sparql:results/sparql:result[1]/sparql:binding[@name='class']"/>
<xsl:variable name="remark" select="sparql:results/sparql:result[1]/sparql:binding[@name='remark']"/>
<xsl:variable name="etymology" select="sparql:results/sparql:result[1]/sparql:binding[@name='etymology']"/>
<xsl:variable name="classetymology" select="sparql:results/sparql:result[1]/sparql:binding[@name='classetymology']"/>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
       <link rel="stylesheet" type="text/css" media="screen" href="style.css"/>
       <title>
	 <xsl:text>Order: </xsl:text><xsl:value-of select="$order"/>
       </title>
    </head>
    <body>
<div id="content">
        <div class="name">
            <div class="scientific"><xsl:text>Order </xsl:text><xsl:value-of select="$order"/></div>
            <div class="common"><xsl:value-of select="$common"/></div>
        </div>
	<div class="details">
	  <div class="detail">
	    <div class="category">Class</div>
	    <div class="value">
	      <xsl:value-of select="$class"/> 
	    </div>
	    <div class="category">Etymology (Order)</div>
	    <div class="value">
	      <xsl:value-of select="$etymology"/> 
	    </div>
	    <div class="category">Etymology (Class)</div>
	    <div class="value">
	      <xsl:value-of select="$classetymology"/> 
	    </div>
	    <div class="category">Remark</div>
	    <div class="value">
	      <xsl:value-of select="$remark" disable-output-escaping="yes"/> 
	    </div>
	    <div class="category">Families</div>
	    <div class="value">
	      <xsl:for-each select="sparql:results/sparql:result">
		<a><xsl:attribute name="href">family.php?uri=<xsl:value-of select="sparql:binding[@name='family']"/></xsl:attribute><xsl:value-of select="sparql:binding[@name='famFamily']"/></a><xsl:text> </xsl:text>

	      </xsl:for-each>
	    </div>

	  </div>

	</div>
	<div class="fblink">
	  <a><xsl:attribute name="href">http://www.fishbase.org/Summary/OrdersSummary.php?Order=<xsl:value-of select="$order"/></xsl:attribute>FishBase page</a> 
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
