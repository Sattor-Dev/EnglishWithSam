<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	agent_002.xsl
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
	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0" style="position:relative; z-index:0; top:0px; left:0px;">
		<xsl:attribute name="id"><xsl:value-of select="$objectID" />_fpobj</xsl:attribute>
		<xsl:attribute name="name"><xsl:value-of select="$objectID" />_fpobj</xsl:attribute>
		<xsl:attribute name="width">100%</xsl:attribute>
		<xsl:attribute name="height">100%</xsl:attribute>
		<param name="FlashVars">
			<xsl:attribute name="value">objID=<xsl:value-of select="$objectID" /></xsl:attribute>
		</param>
		<param name="Movie">
			<xsl:attribute name="value"><xsl:value-of select="$imagesFolder" /><xsl:value-of select="agent" />/agent002_a000_0.swf</xsl:attribute>
		</param>
		<param name="SWLiveConnect" value="1"/>
		<param name="Play" value="1"/>
		<param name="Loop" value="-1"/>
		<param name="Quality" value="High"/>
		<param name="SAlign" value=""/>
		<param name="Menu" value="-1"/>
		<param name="Base" value=""/>
		<param name="AllowScriptAccess" value="always"/>
		<param name="Scale" value="ShowAll"/>
		<param name="DeviceFont" value="0"/>
		<param name="EmbedMovie" value="0"/>
		<param name="BGColor" value=""/>
		<param name="SWRemote" value=""/>
		<param name="MovieData" value=""/>
		<param name="SeamlessTabbing" value="1"/>
		<param name="WMode">
			<xsl:attribute name="value"><xsl:value-of select="wmode" /></xsl:attribute>
		</param>
		<param name="BGColor">
			<xsl:attribute name="value"><xsl:value-of select="bgcolor" /></xsl:attribute>
		</param>
		<param name="swliveconnect">
			<xsl:attribute name="value">true</xsl:attribute>
		</param>
		<embed quality="high" type="application/x-shockwave-flash" pluginspace="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">
			<xsl:attribute name="id"><xsl:value-of select="$objectID" />_fpobj</xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="$objectID" />_fpobj</xsl:attribute>
			<xsl:attribute name="src"><xsl:value-of select="$imagesFolder" /><xsl:value-of select="agent" />/agent002_a000_0.swf</xsl:attribute>
			<xsl:attribute name="bgcolor"><xsl:value-of select="bgcolor" /></xsl:attribute>
			<xsl:attribute name="width">100%</xsl:attribute>
			<xsl:attribute name="width">100%</xsl:attribute>
			<xsl:attribute name="swliveconnect">true</xsl:attribute>
			<xsl:attribute name="flashvars">objID=<xsl:value-of select="$objectID" /></xsl:attribute>
		</embed>
	</object>
</xsl:template>
</xsl:stylesheet>
