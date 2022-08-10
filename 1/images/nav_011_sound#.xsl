<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	nav_011_sound#.xsl
'*	Copyright (c) Websoft, 2007.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="moduleImagesFolder"></xsl:param>
<!--		 Template: Root    -->
<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>
<!--		 Template: Params    -->
<xsl:template match="params">
	<xsl:if test="standard='yes'">
	<img width="27" height="24" border="0">
		<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="tabcolor"/>\btn_sound_on_0.gif</xsl:attribute>
	</img>
	</xsl:if>
	<xsl:if test="standard='no'">
	<img border="0">
		<xsl:attribute name="src"><xsl:value-of select="substring-before($moduleImagesFolder,'images\')"/><xsl:value-of select="translate(n1_img,'/','\')"/></xsl:attribute>
	</img>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
