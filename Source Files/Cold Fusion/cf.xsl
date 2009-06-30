<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:x="http://www.w3.org/1999/xhtml">

<!--

-->

    <xsl:output method='xml' encoding="utf-8" />

    <xsl:variable name="tab" select="'&#09;'" />

	<xsl:template match="/">
		<xsl:copy-of select="x:html/x:head/x:title" disable-output-escaping="yes" />
	</xsl:template>


    <xsl:template match="node() | comment() | processing-instruction()">
        <xsl:apply-templates />
    </xsl:template>
    
</xsl:stylesheet>