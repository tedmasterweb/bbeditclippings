<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--

-->

    <xsl:output method='text' encoding="utf-8" />

    <xsl:variable name="tag_file_and_address">
    	<xsl:text disable-output-escaping="yes">*.js	0;"</xsl:text>
    </xsl:variable>
    
    <xsl:variable name="tab" select="'&#09;'" />

	<xsl:template match="/">
		<xsl:apply-templates select="//function">
			<xsl:sort select="@name" data-type="text" order="ascending" />
		</xsl:apply-templates>
	</xsl:template>


	<xsl:template match="function">
		<xsl:variable name="this_name" select="@name" />
		<xsl:variable name="this_id" select="generate-id()" />
		<xsl:variable name="safe_name">
			<xsl:choose>
				<xsl:when test="preceding-sibling::function/@name = $this_name or following-sibling::function/@name = $this_name">
					<xsl:for-each select="//function[@name = $this_name]">
						<xsl:if test="$this_id = generate-id()">
							<xsl:value-of select="@name" disable-output-escaping="yes" />
							<xsl:text disable-output-escaping="yes">_</xsl:text>
							<xsl:value-of select="position()" disable-output-escaping="yes" />
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@name" disable-output-escaping="yes" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:document href="./jQuery.js/{$safe_name}" method="text">
			<xsl:text>#indent#
</xsl:text>
			<xsl:choose>
				<xsl:when test="contains(@name, 'jQuery.')">
					<xsl:value-of select="@name" disable-output-escaping="yes" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>$("#selstart#Selector#selend#").</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="@name" disable-output-escaping="yes" />
			<xsl:if test="count(params) &gt; 0">
				<xsl:text disable-output-escaping="yes">( </xsl:text>
				<xsl:apply-templates select="params"/>
				<xsl:text disable-output-escaping="yes"> )</xsl:text>
			</xsl:if>
		</xsl:document>
	</xsl:template>
	
	
	<xsl:template match="params">
		<xsl:text disable-output-escaping="yes">#placeholderstart#</xsl:text>
		<xsl:if test="position() != 1">
			<xsl:text disable-output-escaping="yes">, </xsl:text>
		</xsl:if>
		<xsl:if test="contains(@type, 'optional')">
			<xsl:text disable-output-escaping="yes">[</xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="contains(@type, ',')">
				<xsl:value-of select="translate(normalize-space(@type), ', ', '/')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="normalize-space(@type)" disable-output-escaping="yes" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text disable-output-escaping="yes"> </xsl:text>
		<xsl:value-of select="@name" disable-output-escaping="yes" />
		<xsl:if test="contains(@type, 'optional')">
			<xsl:text disable-output-escaping="yes">]</xsl:text>
		</xsl:if>
		<xsl:text disable-output-escaping="yes">#placeholderend#</xsl:text>
	</xsl:template>


    <xsl:template match="node() | comment() | processing-instruction()">
        <xsl:apply-templates />
    </xsl:template>
    
</xsl:stylesheet>