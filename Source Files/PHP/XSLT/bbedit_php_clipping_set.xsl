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
    <xsl:variable name="glossary_folder_name" select="concat($output_dir, '/PHP.php')" />
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
        <xsl:for-each select="(db:set/db:set[@xml:id = 'funcref']/db:set/db:book|db:set/db:book[@xml:id = 'langref']/db:chapter[@xml:id = 'language.constants']/db:sect1[@xml:id = 'language.constants.predefined'])/descendant::db:constant[count(. | key('all-constants', .)[1]) = 1]">
            <xsl:sort select="." data-type="text" order="ascending" />
            <xsl:variable name="constant">
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
                        <xsl:variable name="us_constant_name">
                            <xsl:call-template name="symbol-name" />
                        </xsl:variable>
                        <xsl:variable name="s_constant_name" select="translate($us_constant_name, translate($us_constant_name, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_', ''), '')" />
                        <xsl:if test="$us_constant_name = $s_constant_name">
                            <xsl:value-of select="$s_constant_name" disable-output-escaping="yes" />
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:if test="$constant != ''">
                <xsl:variable name="gtsr_glossary_filename" select="concat($constants_folder, '/', $constant)" />
                <xsl:document href="{$gtsr_glossary_filename}" method="text">
                    <xsl:text disable-output-escaping="yes">#indent#
</xsl:text>
                    <xsl:value-of select="$constant" disable-output-escaping="yes" />
                </xsl:document>
            </xsl:if>
        </xsl:for-each>
		<xsl:apply-templates select="db:set/db:set[@xml:id = 'funcref']/db:set/db:book" />
		<xsl:apply-templates select="db:set/db:set[@xml:id = 'langref']/db:part[xml:id = 'reserved.exceptions']/phpdoc:exceptionref/descendant::db:classsynopsis" />
	</xsl:template>


	<xsl:template match="db:book">
		<!-- constants -->
		<!-- methods and functions -->
		<!-- properties -->
		<xsl:apply-templates select="db:reference" />
		<xsl:apply-templates select="phpdoc:classref" />
	</xsl:template>
	
	
    <xsl:template match="db:reference">
        <xsl:if test="contains($functions, @xml:id) or $functions = ''">
            <xsl:apply-templates select="db:refentry/db:refsect1/descendant::db:methodsynopsis[db:methodname[count(db:replaceable) = 0]]" />
            <xsl:apply-templates select="db:refentry/db:refsect1/db:classsynopsis/descendant::db:fieldsynopsis" />
        </xsl:if>
    </xsl:template>


	<xsl:template match="phpdoc:classref">
<!-- 
		<xsl:if test="count(db:partintro/db:section[contains(@xml:id, '.props')]/db:variablelist/db:varlistentry/db:term/db:varname) &gt; 0">
			<xsl:apply-templates select="db:partintro/db:section[contains(@xml:id, '.props')]/db:variablelist/db:varlistentry/db:term/db:varname" />
		</xsl:if>
 -->
		<xsl:apply-templates select="db:partintro/db:section/descendant::db:methodsynopsis[db:methodname[count(db:replaceable) = 0]]" />
		<xsl:apply-templates select="db:partintro/db:section/db:classsynopsis/descendant::db:fieldsynopsis"/>
		<xsl:apply-templates select="db:refentry/db:refsect1/descendant::db:methodsynopsis[db:methodname[count(db:replaceable) = 0]]" />
	</xsl:template>
	
	
	<xsl:template match="db:methodsynopsis">
		<xsl:apply-templates select="db:methodname[count(db:replaceable) = 0]">
		    <xsl:sort select="db:methodname" data-type="text" order="ascending" />
		</xsl:apply-templates>
	</xsl:template>
	
	
	<xsl:template match="db:methodname">
		<xsl:variable name="this_methodname" select="." />
		<!-- class -->
		<xsl:variable name="class">
            <xsl:choose>
                <xsl:when test="count(ancestor::db:classsynopsis/db:ooclass/db:classname) &gt; 0">
                    <xsl:value-of select="ancestor::db:classsynopsis/db:ooclass/db:classname" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:when test="contains(., '::') or contains(., '-&gt;')">
                    <xsl:choose>
                        <xsl:when test="contains(., '::')">
                            <xsl:value-of select="substring-before(., '::')" disable-output-escaping="yes" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="substring-before(., '-&gt;')" disable-output-escaping="yes" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text disable-output-escaping="yes"></xsl:text>
                </xsl:otherwise>
            </xsl:choose>
		</xsl:variable>
		<xsl:variable name="filename">
            <xsl:choose>
                <xsl:when test="$class != ''">
                    <xsl:value-of select="concat($methods_folder, '/', $class, '/')" disable-output-escaping="yes" />
                    <xsl:call-template name="symbol-name" />
                    <xsl:value-of select="concat('_', $class, '_method')" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($functions_folder, '/')" disable-output-escaping="yes" />
                    <xsl:call-template name="symbol-name" />
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="count(ancestor::db:refsect1/db:methodsynopsis/db:methodname[. = $this_methodname]) &gt; 1">
            	<xsl:variable name="this_id">
            		<xsl:value-of select="generate-id()" disable-output-escaping="yes" />
            	</xsl:variable>
            	<xsl:for-each select="ancestor::db:refsect1/db:methodsynopsis/db:methodname[. = $this_methodname]">
            		<xsl:if test="generate-id() = $this_id">
            			<xsl:value-of select="concat('_', position())" disable-output-escaping="yes" />
            		</xsl:if>
            	</xsl:for-each>
            </xsl:if>
		</xsl:variable>
		<xsl:document href="{$filename}" method="text">
		    <xsl:text disable-output-escaping="yes">#indent#
</xsl:text>
            <xsl:if test="$class != ''">
                <xsl:text disable-output-escaping="yes">#placeholderstart# </xsl:text>
                <xsl:value-of select="$class" disable-output-escaping="yes" />
                <xsl:text disable-output-escaping="yes"> #placeholderend#-&gt;</xsl:text>
            </xsl:if>
            <xsl:call-template name="symbol-name" />
            <xsl:value-of select="$space" disable-output-escaping="yes" />
            <!-- signature -->
            <xsl:choose>
            	<xsl:when test="count(following-sibling::db:void) &gt; 0">
                    <xsl:text disable-output-escaping="yes">()</xsl:text>
            	</xsl:when>
            	<xsl:otherwise>
                    <xsl:if test="count(following-sibling::db:methodparam) &gt; 0">
                        <xsl:text disable-output-escaping="yes">(</xsl:text>
                        <xsl:value-of select="$space" disable-output-escaping="yes" />
                        <xsl:apply-templates select="following-sibling::db:methodparam"/>
                        <xsl:value-of select="$space" disable-output-escaping="yes" />
                        <xsl:text disable-output-escaping="yes">)</xsl:text>
                    </xsl:if>
            	</xsl:otherwise>
            </xsl:choose>
            <xsl:text disable-output-escaping="yes">#placeholderstart# ; #placeholderend#</xsl:text>
        </xsl:document>
	</xsl:template>


	<xsl:template match="db:methodparam">
        <!-- if NOT optional, comma not included in placeholder -->
        <!--
        Examples:
        functionname(string param1, string param2<#, [string param3]#><#, [string param4]#>)
        -->
        <xsl:variable name="use-date-dialog">
        	<xsl:if test="ancestor::db:methodsynopsis/db:methodname = 'date' or ancestor::db:methodsynopsis/db:methodname = 'date_format' or ancestor::db:methodsynopsis/db:methodname = 'date_parse_from_format' or ancestor::db:methodsynopsis/db:methodname = 'DateTime::format' or ancestor::db:methodsynopsis/db:methodname = 'DateTime::createFromFormat'">
        		<xsl:if test="normalize-space(db:parameter) = 'format'">
        			<xsl:text disable-output-escaping="yes">true</xsl:text>
        		</xsl:if>
        	</xsl:if>
        </xsl:variable>
        
        <xsl:choose>
        	<xsl:when test="$use-date-dialog = 'true'">
        		<xsl:text>#script call date format dialog.scpt#</xsl:text>
        	</xsl:when>
        	<xsl:otherwise>
				<xsl:text>#placeholderstart#</xsl:text>
				<xsl:if test="@choice = 'opt'">
					<xsl:text disable-output-escaping="yes">[</xsl:text>
				</xsl:if>
				<xsl:if test="position() != 1">
					<xsl:text disable-output-escaping="yes">,</xsl:text>
				</xsl:if>
				<xsl:text disable-output-escaping="yes"> </xsl:text>
				<xsl:value-of select="normalize-space(db:type)" />
				<xsl:text disable-output-escaping="yes"> </xsl:text>
				<xsl:value-of select="normalize-space(db:parameter)" />
				<xsl:text disable-output-escaping="yes"> </xsl:text>
				<xsl:if test="@choice = 'opt'">
					<xsl:text disable-output-escaping="yes">]</xsl:text>
				</xsl:if>
				<xsl:text>#placeholderend#</xsl:text>
        	</xsl:otherwise>
        </xsl:choose>
	</xsl:template>
	
	
	<xsl:template match="db:fieldsynopsis">
		<xsl:apply-templates select="db:varname">
		    <xsl:sort select="." data-type="text" order="ascending" />
		</xsl:apply-templates>
	</xsl:template>
	
	
	
	<xsl:template match="db:varname">
		<xsl:variable name="class">
            <xsl:choose>
                <xsl:when test="count(ancestor::db:classsynopsis/db:ooclass/db:classname) &gt; 0">
                    <xsl:value-of select="ancestor::db:classsynopsis/db:ooclass/db:classname" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:when test="contains(., '::') or contains(., '-&gt;')">
                    <xsl:choose>
                        <xsl:when test="contains(., '::')">
                            <xsl:value-of select="substring-before(., '::')" disable-output-escaping="yes" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="substring-before(., '-&gt;')" disable-output-escaping="yes" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text disable-output-escaping="yes"></xsl:text>
                </xsl:otherwise>
            </xsl:choose>
		</xsl:variable>
        <xsl:variable name="filename">
        	<xsl:choose>
        		<xsl:when test="$class != ''">
        			<xsl:value-of select="concat($properties_folder, '/', $class, '/')" disable-output-escaping="yes" />
                    <xsl:call-template name="symbol-name" />
                    <xsl:value-of select="concat('_', $class, '_property')" disable-output-escaping="yes" />
        		</xsl:when>
        		<xsl:otherwise>
        			<xsl:value-of select="concat($misc_folder, '/')" disable-output-escaping="yes" />
                    <xsl:call-template name="symbol-name" />
        		</xsl:otherwise>
        	</xsl:choose>
        </xsl:variable>
        <xsl:document href="{$filename}" method="text">
            <xsl:text disable-output-escaping="yes">#indent#
</xsl:text>
            <xsl:text disable-output-escaping="yes">#placeholderstart# ClassVar #placeholderend#-&gt;</xsl:text>
            <xsl:call-template name="symbol-name" />
            <xsl:text disable-output-escaping="yes">#placeholderstart# ; #placeholderend#</xsl:text>
        </xsl:document>
	</xsl:template>


    <xsl:template match="node() | @xml:* | comment() | processing-instruction()">
            <xsl:apply-templates select="@xml:* | node()"/>
    </xsl:template>





    <xsl:template name="symbol-name">
        <xsl:choose>
            <xsl:when test="contains(., '::') or contains(., '-&gt;')">
                <xsl:choose>
                    <xsl:when test="contains(., '::')">
                        <xsl:value-of select="substring-after(., '::')" disable-output-escaping="yes" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="substring-after(., '-&gt;')" disable-output-escaping="yes" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="." disable-output-escaping="yes" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template name="folder-name">
        <!-- make dots into hyphens -->
        <xsl:variable name="function_folder_name">
            <xsl:choose>
                <xsl:when test="normalize-space(preceding-sibling::db:titleabbrev) = ''">
                    <xsl:value-of select="translate(normalize-space(preceding-sibling::db:title), '.', '-')" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="translate(normalize-space(preceding-sibling::db:titleabbrev), '.', '-')" disable-output-escaping="yes" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!-- make spaces into underscores -->
        <xsl:variable name="function_folder_name1" select="translate ($function_folder_name, ' ', '_')" />
        <!-- remove everything except alphanum, hyphens, and underscores -->
        <xsl:variable name="function_folder_name2" select="translate($function_folder_name1, translate($function_folder_name1, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-_', ''), '')" />
    </xsl:template>
    
    
</xsl:stylesheet>