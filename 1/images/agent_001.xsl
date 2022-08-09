<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:websoft="http://www.websoft.ru" version="1.0">
<!--
'*	agent_001.xsl
'*	Copyright (c) Websoft Ltd., Russia.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>

<xsl:param name="objectID"/>
<xsl:param name="width"/>
<xsl:param name="height"/>
<xsl:param name="imagesFolder"/>
<xsl:param name="moduleImagesFolder"/>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">
	<xsl:variable name="codebaseurl">
		<xsl:choose>
			<xsl:when test="https='yes'">https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0</xsl:when>
			<xsl:otherwise>http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID" />_CONTAINER</xsl:attribute>
		<xsl:attribute name="style">position: absolute; top: 0px; left: 0px; width: <xsl:value-of select="$width" />px; height: <xsl:value-of select="$height" />px;</xsl:attribute>
		<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">
			<xsl:attribute name="id"><xsl:value-of select="$objectID" />_FPOBJECT_IE</xsl:attribute>
			<xsl:attribute name="style">position: absolute; top: 0px; left: 0px; width: <xsl:value-of select="$width" />px; height: <xsl:value-of select="$height" />px;</xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="$width" /></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="$height" /></xsl:attribute>
			<xsl:attribute name="codebase"><xsl:value-of select="$codebaseurl" /></xsl:attribute>
			
			<param name="allowScriptAccess" value="always"/>
			<param name="movie"><xsl:attribute name="value"><xsl:value-of select="$imagesFolder" /><xsl:value-of select="agent"/>.swf</xsl:attribute></param>
			<param name="bgcolor"><xsl:attribute name="value"><xsl:if test="wmode!='transparent'"><xsl:value-of select="bgcolor" /></xsl:if></xsl:attribute></param>
			<param name="menu" value="false"/>
			<param name="play" value="true"/>
			<param name="quality" value="High"/>
			<param name="salign" value=""/>
			<param name="scale" value="showall"/>
			<param name="swliveconnect" value="true"/>
			<param name="swremote" value=""/>
			<param name="wmode"><xsl:attribute name="value"><xsl:value-of select="wmode" /></xsl:attribute></param>
			<param name="flashvars"><xsl:attribute name="value">objID=<xsl:value-of select="$objectID" />&amp;objTemplate=agent_001</xsl:attribute></param>
		</object>
		<object type="application/x-shockwave-flash">
			<xsl:attribute name="id"><xsl:value-of select="$objectID" />_FPOBJECT_W3C</xsl:attribute>
			<xsl:attribute name="style">position: absolute; top: 0px; left: 0px; width: <xsl:value-of select="$width" />px; height: <xsl:value-of select="$height" />px;</xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="$width" /></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="$height" /></xsl:attribute>
			<xsl:attribute name="data"><xsl:value-of select="$imagesFolder" /><xsl:value-of select="agent"/>.swf</xsl:attribute>
	
			<param name="allowscriptaccess" value="always"/>
			<param name="base" value=""/>
			<param name="bgcolor"><xsl:attribute name="value"><xsl:if test="wmode!='transparent'"><xsl:value-of select="bgcolor" /></xsl:if></xsl:attribute></param>
			<param name="menu" value="false"/>
			<param name="play" value="true"/>
			<param name="quality" value="High"/>
			<param name="salign" value=""/>
			<param name="scale" value="showall"/>
			<param name="swliveconnect" value="true"/>
			<param name="swremote" value=""/>
			<param name="wmode"><xsl:attribute name="value"><xsl:value-of select="wmode" /></xsl:attribute></param>
			<param name="flashvars"><xsl:attribute name="value">objID=<xsl:value-of select="$objectID" />&amp;objTemplate=agent_001</xsl:attribute></param>
		</object>
	</div>
</xsl:template>

</xsl:stylesheet>
