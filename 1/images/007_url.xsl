<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	007_url#.xsl 
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
	<xsl:if test="standard='yes'">
	<img width="22" height="20" border="0" alt="New browser window">
		<xsl:attribute name="style">cursor:pointer;</xsl:attribute>
		<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>icon_url.gif</xsl:attribute>
		<xsl:attribute name="onclick">window.open('<xsl:value-of select="jump_url"/>','newwindow','toolbar=<xsl:value-of select="wtoolbar"/>,location=<xsl:value-of select="wlocation"/>,status=<xsl:value-of select="wstatus"/>,menubar=<xsl:value-of select="wmenubar"/>,resizable=<xsl:value-of select="wresize"/>,scrollbars=<xsl:value-of select="wscroll"/>, width=<xsl:value-of select="wx"/>,height=<xsl:value-of select="wy"/>'); return false;</xsl:attribute>
	</img>
	</xsl:if>
	<xsl:if test="standard='no'">
	<img border="0">
		<xsl:attribute name="style">cursor:pointer;</xsl:attribute>
		<xsl:attribute name="src"><xsl:value-of select="n1_img"/></xsl:attribute>
		<xsl:attribute name="onclick">window.open('<xsl:value-of select="jump_url"/>','newwindow','toolbar=<xsl:value-of select="wtoolbar"/>,location=<xsl:value-of select="wlocation"/>,status=<xsl:value-of select="wstatus"/>,menubar=<xsl:value-of select="wmenubar"/>,resizable=<xsl:value-of select="wresize"/>,scrollbars=<xsl:value-of select="wscroll"/>, width=<xsl:value-of select="wx"/>,height=<xsl:value-of select="wy"/>'); return false;</xsl:attribute>
	</img>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
