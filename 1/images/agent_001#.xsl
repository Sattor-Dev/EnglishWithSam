<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:websoft="http://www.websoft.ru" version="1.0">
<!--
'*    agent_001#.xsl
'*    Copyright (c) Websoft Ltd., Russia  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>

<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="width"></xsl:param>
<xsl:param name="height"></xsl:param>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">
	<div align="center">
		<xsl:if test="wmode!='transparent'"><xsl:attribute name="style">background-color: <xsl:value-of select="bgcolor"/></xsl:attribute></xsl:if>
		<img vspace="0">
			<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
			<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>agent_001_<xsl:value-of select="agent"/>.gif</xsl:attribute>
		</img>
	</div>
</xsl:template>

</xsl:stylesheet>
