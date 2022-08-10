<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	media_005_fvp#.xsl
'*	Copyright (c) Websoft, 2006.  All rights reserved.
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
<div>
	<xsl:attribute name="id"><xsl:value-of select="$objectID" />_fvpcontainer</xsl:attribute>
	<xsl:if test="ffile='yes'"><xsl:value-of select="flash_uri"/></xsl:if>
	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" width="1" height="1">
		<param name="movie"><xsl:if test="video_controls='no'"><xsl:value-of select="$imagesFolder"/>player0.swf</xsl:if><xsl:if test="video_controls='full'"><xsl:value-of select="$imagesFolder"/>player1.swf</xsl:if></param>
	</object>
</div>
</xsl:template>
</xsl:stylesheet>
