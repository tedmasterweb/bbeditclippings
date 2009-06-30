<?xml version='1.0' encoding='utf-8'?>
<!--
I print out the total number of methods, properties, and constants available for a clipping set.

Methods are broken down into members of a class and stand-alone (functions)

Class methods include the visibility in addition to the return type (same for parameters)

All fieldsynopsis elements are children of classsynopsis under the db namespace

function.set-error-handler is an example of a section in which the "replaceable" element is used, which means it should be skipped

These are the 6 places we can find methods/functions
/set/set/set/book/phpdoc:classref/partintro/section/classsynopsis/fieldsynopsis
/set/set/set/book/phpdoc:classref/partintro/section/classsynopsis/methodsynopsis
/set/set/set/book/reference/refentry/refsect1/classsynopsis/fieldsynopsis
/set/set/set/book/reference/refentry/refsect1/classsynopsis/methodsynopsis
/set/set/set/book/reference/refentry/refsect1/methodsynopsis
/set/set/set/book/reference/refentry/refsect1/para/variablelist/varlistentry/listitem/methodsynopsis

There do not appear to be any duplicates in the source documentation.

- Constants should be unique (no duplicates)
- OO methods should be method_name_Object rather than method_name_oo (which doesn't tell the complete story), also post-pending the object name makes bringing up the funciton faster

-->
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform' xmlns:db="http://docbook.org/ns/docbook" xmlns:phpdoc="http://php.net/ns/phpdoc">

	<xsl:output method='xml' omit-xml-declaration="yes" version='1.0' encoding='utf-8' indent='yes'/>
	
	<xsl:strip-space elements="*" />

	<xsl:key name="all-constants" match="db:constant" use="." />

	<xsl:template match="/">
		<xsl:for-each select="(db:set/db:set[@xml:id = 'funcref']/db:set/db:book|db:set/db:book[@xml:id = 'langref']/db:chapter[@xml:id = 'language.constants']/db:sect1[@xml:id = 'language.constants.predefined'])/descendant::db:constant[count(. | key('all-constants', .)[1]) = 1]">
			<xsl:choose>
				<!-- skip markers flagged as constants but annoying in the context of auto-completion -->
				<xsl:when test=". = '\0'">
					
				</xsl:when>
				<xsl:when test=". = '\n'">
					
				</xsl:when>
				<xsl:when test=". = '\r'">
					
				</xsl:when>
				<xsl:when test=". = '0'">
					
				</xsl:when>
				<xsl:when test=". = '128000'">
					
				</xsl:when>
				<xsl:when test=". = '2'">
					
				</xsl:when>
				<xsl:when test=". = '44100'">
					
				</xsl:when>
				<xsl:when test=". = 'e'">
					
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="contains(., '::')">
							<xsl:variable name="scope" select="substring-before(., '::')" />
							<xsl:variable name="target_orig" select="substring-after(., '::')" />
							<xsl:variable name="target" select="translate($target_orig, translate($target_orig, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_', ''), '')" />
							<xsl:if test="$target_orig = $target">
								<xsl:value-of select="concat($target, '__', $scope)" disable-output-escaping="yes" />
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:variable name="target" select="translate(., translate(., 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_', ''), '')" />
							<xsl:if test=". = $target">
								<xsl:value-of select="." disable-output-escaping="yes" />
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text disable-output-escaping="yes">
</xsl:text>
		</xsl:for-each>
		<xsl:apply-templates select="db:set/db:set[@xml:id = 'funcref']/db:set/db:book" />
	</xsl:template>


	<xsl:template match="db:book">
		<!-- constants -->
		<!-- methods and functions -->
		<!-- properties -->
		<xsl:apply-templates select="db:reference" />
		<xsl:apply-templates select="phpdoc:classref" />
	</xsl:template>
	
	
	<xsl:template match="db:reference">
		<xsl:apply-templates select="db:refentry/db:refsect1/descendant::db:methodsynopsis/db:methodname[count(db:replaceable) = 0]"/>
		<xsl:apply-templates select="db:refentry/db:refsect1/db:classsynopsis"/>
	</xsl:template>
	


	<xsl:template match="phpdoc:classref">
<!-- 
		<xsl:if test="count(db:partintro/db:section[contains(@xml:id, '.props')]/db:variablelist/db:varlistentry/db:term/db:varname) &gt; 0">
			<xsl:apply-templates select="db:partintro/db:section[contains(@xml:id, '.props')]/db:variablelist/db:varlistentry/db:term/db:varname" />
		</xsl:if>
 -->
		<xsl:apply-templates select="db:partintro/db:section/descendant::db:methodsynopsis/db:methodname[count(db:replaceable) = 0]"/>
		<xsl:apply-templates select="db:partintro/db:section/db:classsynopsis"/>
	</xsl:template>
	
	
	<xsl:template match="db:classsynopsis">
		<xsl:apply-templates select="descendant::db:fieldsynopsis/db:varname"/>
	</xsl:template>
	

	<xsl:template match="db:methodname">
		<xsl:value-of select="generate-id()" disable-output-escaping="yes" />
		<xsl:text disable-output-escaping="yes">: </xsl:text>
		<xsl:call-template name="getPath" />
		<xsl:text disable-output-escaping="yes">
</xsl:text>
	</xsl:template>


	<xsl:template match="db:varname">
		<xsl:value-of select="generate-id()" disable-output-escaping="yes" />
		<xsl:text disable-output-escaping="yes">: </xsl:text>
		<xsl:call-template name="getPath" />
		<xsl:text disable-output-escaping="yes">
</xsl:text>
	</xsl:template>


<!-- 
	<xsl:template match="db:varname">
		<xsl:value-of select="ancestor::phpdoc:classref/db:titleabbrev" disable-output-escaping="yes" />
		<xsl:text disable-output-escaping="yes">-&gt;</xsl:text>
		<xsl:value-of select="." disable-output-escaping="yes" />
		<xsl:text disable-output-escaping="yes">
</xsl:text>
	</xsl:template>
 -->
	
	
	
	
	<xsl:template match="node() | @* | comment() | processing-instruction()">
		<xsl:apply-templates />
	</xsl:template>
	
	
	<xsl:template name="getPath">
		<xsl:for-each select="ancestor::*">
			<xsl:text disable-output-escaping="yes">/</xsl:text>
			<xsl:value-of select="name()" disable-output-escaping="yes" />
		</xsl:for-each>
		<xsl:text disable-output-escaping="yes">/</xsl:text>
		<xsl:choose>
			<xsl:when test="count(descendant-or-self::db:methodname) = 0">
				<xsl:choose>
					<xsl:when test="descendant-or-self::db:varname = ''">
						<xsl:value-of select="descendant-or-self::db:varname/@linkend" disable-output-escaping="yes" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="descendant-or-self::db:varname" disable-output-escaping="yes" />
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text disable-output-escaping="yes"> (</xsl:text>
				<xsl:value-of select="ancestor::db:section/@xml:id" disable-output-escaping="yes" />
				<xsl:text disable-output-escaping="yes">, </xsl:text>
				<xsl:value-of select="ancestor-or-self::db:refentry/@xml:id" disable-output-escaping="yes" />
				<xsl:text disable-output-escaping="yes">, </xsl:text>
				<xsl:value-of select="ancestor-or-self::db:refsect1/@role" disable-output-escaping="yes" />
				<xsl:text disable-output-escaping="yes">)</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="descendant-or-self::db:methodname" disable-output-escaping="yes" />
				<xsl:text disable-output-escaping="yes"> (</xsl:text>
				<xsl:value-of select="ancestor::db:reference/@xml:id" disable-output-escaping="yes" />
				<xsl:text disable-output-escaping="yes">, </xsl:text>
				<xsl:value-of select="ancestor-or-self::db:refentry/@xml:id" disable-output-escaping="yes" />
				<xsl:text disable-output-escaping="yes">, </xsl:text>
				<xsl:value-of select="ancestor-or-self::db:refsect1/@role" disable-output-escaping="yes" />
				<xsl:text disable-output-escaping="yes">)</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
</xsl:stylesheet>