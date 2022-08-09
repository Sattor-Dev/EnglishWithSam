<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	008_iframe#.xsl
'*	Copyright (C) 2005 WebSoft.  All rights reserved. http://www.courselab.ru/
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="objectID"></xsl:param>
<!--		 Template: Root    -->
<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>
<!-- Template: Params -->
<xsl:template match="params">

	<iframe>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_iframe</xsl:attribute>
		<xsl:attribute name="src"><xsl:if test="ifile='yes'"><xsl:value-of select="uri"/></xsl:if><xsl:if test="iURL='yes'"><xsl:value-of select="url"/></xsl:if></xsl:attribute>
		<xsl:attribute name="width">100%</xsl:attribute>
		<xsl:attribute name="height">100%</xsl:attribute>
		<xsl:attribute name="scrolling"><xsl:value-of select="scrolling"/></xsl:attribute>
		<xsl:attribute name="style">border-width: <xsl:value-of select="borderwidth"/>px; border-style: <xsl:value-of select="borderstyle"/>; border-color: <xsl:value-of select="bordercolor"/>;</xsl:attribute>
	</iframe>

</xsl:template>
</xsl:stylesheet>
