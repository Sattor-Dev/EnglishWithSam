<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	media_004_java#.xsl 
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
<table width="100%" height="100%" border="0" cellpadding="10" cellspacing="0">
<tr>
<td width="100%" align="center" valign="middle" bgcolor="FEFEFE">
<img width="72" height="54" vspace="5">
	<xsl:attribute name="src">
		<xsl:value-of select="$imagesFolder"/>media_004_java.gif
	</xsl:attribute>
</img>
<br/>
Applet: <xsl:value-of select="applet_uri" />
</td>
</tr>
</table>
</xsl:template>
</xsl:stylesheet>
