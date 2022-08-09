<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru" version="1.0">
<!--
'*	101_clickarea#.xsl
'*	Copyright (c) Websoft Ltd. Russia.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="moduleImagesFolder"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="width"></xsl:param>
<xsl:param name="height"></xsl:param>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">
	<xsl:variable name="font.size">
		<xsl:choose>
			<xsl:when test="number($width) &gt; number($height)"><xsl:value-of select="$width"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$height"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="ie.opacity">
		<xsl:choose>
			<xsl:when test="string(number(opacity))='NaN'">40</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="(number(opacity) &gt; 100) or (number(opacity) &lt; 0) ">40</xsl:when>
					<xsl:otherwise><xsl:value-of select="opacity"/></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="pre.width">
		<xsl:choose>
			<xsl:when test="borderstyle!='none'"><xsl:value-of select="number($width)-2*number(borderwidth)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$width"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="pre.height">
		<xsl:choose>
			<xsl:when test="borderstyle!='none'"><xsl:value-of select="number($height)-2*number(borderwidth)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$height"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:if test="preview='no'">
		<table border="0" cellspacing="0" cellpadding="0">
			<xsl:attribute name="style">position: absolute; top: 0px; left: 0px; width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
			<tr>
				<td>
					<xsl:attribute name="style">width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; border: #EEEEEE 1px dotted;</xsl:attribute>
					<div style="font-family: Verdana, Arial, sans-serif; font-size:10px; color: #CCCCCC; text-align:center"><xsl:value-of select="hidden.label"/></div>
				</td>
		  </tr>
		</table>
	</xsl:if>
	<xsl:if test="preview='yes'">
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_HIGHLIGHT</xsl:attribute>
			<xsl:attribute name="style">position: absolute; top: 0px; left: 0px; width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; <xsl:if test="borderstyle!='none'">border-style: <xsl:value-of select="borderstyle"/>; border-width: <xsl:value-of select="borderwidth"/>px; border-color: <xsl:value-of select="bordercolor"/>;</xsl:if> font-family: monospace; font-size: <xsl:value-of select="$font.size"/>px; overflow: hidden; background-color: <xsl:value-of select="bgcolor"/>; filter: alpha(opacity=<xsl:value-of select="$ie.opacity"/>); </xsl:attribute>
			&#160;
		</div>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
