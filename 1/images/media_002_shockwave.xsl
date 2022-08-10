<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	media_002_shockwave.xsl 
'*	Copyright (c) Websoft, 2006.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="objectID"></xsl:param>
<!--		 Template: Root    -->
<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>
<!-- Template: Params --> 
<xsl:template match="params">
	<object classid="clsid:166B1BCA-3F9C-11CF-8075-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/director/sw.cab#version=8,5,0,0">
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_sw</xsl:attribute>
		<xsl:attribute name="width">100%</xsl:attribute>
		<xsl:attribute name="height">100%</xsl:attribute>
   			<param name="src">
				<xsl:attribute name="value"><xsl:value-of select="sw_uri" /></xsl:attribute>
			</param>
   			<embed pluginspage="http://www.macromedia.com/shockwave/download/">
				<xsl:attribute name="src"><xsl:value-of select="sw_uri" /></xsl:attribute>
				<xsl:attribute name="width">100%</xsl:attribute>
				<xsl:attribute name="height">100%</xsl:attribute>
			</embed>
	</object>
</xsl:template>
</xsl:stylesheet>
