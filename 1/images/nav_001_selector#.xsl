<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	nav_001_selector#.xsl
'*	Copyright (c) Websoft, 2007.  All rights reserved.
-->

<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="objectID"></xsl:param>
<!--		 Template: Root    -->
<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>
<!--		 Template: Params    -->
<xsl:template match="params">
<select>
	<xsl:attribute name="style">width:100%; text-align:<xsl:value-of select="input_text_align"/>; font-style:<xsl:value-of select="input_font_style"/>;font-weight:<xsl:value-of select="input_font_weight"/>;font-family:<xsl:value-of select="input_font"/>; font-size:<xsl:value-of select="input_font_size"/>px; color:<xsl:value-of select="input_font_color"/>; background-color: <xsl:value-of select="input_bg_color"/>;</xsl:attribute>
	<option value="0">
		<xsl:attribute name="style">background-color: <xsl:value-of select="input_bg_color"/>;</xsl:attribute>
		Slidename list
	</option>
</select>
</xsl:template>

</xsl:stylesheet>
