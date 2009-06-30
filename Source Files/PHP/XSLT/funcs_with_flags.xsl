<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version='1.0' 
    xmlns:xsl='http://www.w3.org/1999/XSL/Transform' 
    xmlns:db="http://docbook.org/ns/docbook" 
    xmlns:phpdoc="http://php.net/ns/phpdoc">

<!--
KNOWN ISSUES
- folder names cannot have spaces in them, including glossary_folder_name.
- some constants are missing because the documentation authors are not using the CONSTANT element

To find the total number of files output by the stylesheet
find . -type f | wc -l

number_format has two versions:
    - the first version has one required parameter and one optional
    - the second version has 4 required parameters
    Currently the first version is being added manually

copyright 2004 Ted Stresen-Reuter
http://www.tedmasterweb.com/php-bbedit-clipping-set/
-->

<xsl:output method='text' encoding="utf-8" />

	<xsl:key name="all-constants" match="db:constant" use="." />

    <xsl:strip-space elements="*" />
    
    <xsl:param name="save" />
    <xsl:param name="do_constants" />
    <xsl:param name="verbose" />
    <xsl:param name="functions" />
    <xsl:param name="output_dir" />
    <xsl:param name="style" />
    <xsl:param name="return-vars-and-modifiers" />
    
    <!-- This is the name of the folder the glossary will be stored in -->
    <xsl:variable name="glossary_folder_name" select="concat($output_dir, '/PHP_Glossary.php')" />
    <xsl:variable name="functions_folder" select="concat($glossary_folder_name, '/Functions')" />
    <xsl:variable name="constants_folder" select="concat($glossary_folder_name, '/Constants')" />
    <xsl:variable name="classes_folder" select="concat($glossary_folder_name, '/Classes')" />
    <xsl:variable name="methods_folder" select="concat($classes_folder, '/Methods')" />
    <xsl:variable name="properties_folder" select="concat($classes_folder, '/Properties')" />
    <xsl:variable name="misc_folder" select="concat($glossary_folder_name, '/Misc')" />
    
    <xsl:variable name="space">
    	<xsl:choose>
    		<xsl:when test="$style = 'zend'">
    			<xsl:text disable-output-escaping="yes"></xsl:text>
    		</xsl:when>
    		<xsl:otherwise>
    			<xsl:value-of select="' '" disable-output-escaping="yes" />
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:variable>



    <xsl:template match="/">
		<xsl:apply-templates select="db:set/db:set[@xml:id = 'funcref']/db:set/db:book" />
	</xsl:template>


	<xsl:template match="db:book">
		<!-- constants -->
		<!-- methods and functions -->
		<!-- properties -->
		<xsl:apply-templates select="db:reference" />
	</xsl:template>
	
	
    <xsl:template match="db:reference">
        <xsl:if test="contains($functions, @xml:id) or $functions = ''">
            <xsl:apply-templates select="db:refentry/db:refsect1" />
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="db:refsect1">
    	<xsl:value-of select="db:methodsynopsis/db:methodname" disable-output-escaping="yes" />
		<xsl:text disable-output-escaping="yes">
</xsl:text>
    	<xsl:apply-templates select="descendant::db:variablelist/db:varlistentry/descendant::db:constant" />
    </xsl:template>
    

	<xsl:template match="db:constant">
		<xsl:text disable-output-escaping="yes">: </xsl:text>
		<xsl:value-of select="." disable-output-escaping="yes" />
		<xsl:text disable-output-escaping="yes">
</xsl:text>
	</xsl:template>
	


    <xsl:template match="node() | @xml:* | comment() | processing-instruction()">
            <xsl:apply-templates select="@xml:* | node()"/>
    </xsl:template>


    
</xsl:stylesheet>