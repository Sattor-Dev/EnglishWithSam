<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	agent_002#.xsl
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
<table width="145" height="200" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="145">
			<xsl:if test="wmode!='transparent'">
				<xsl:attribute name="bgcolor"><xsl:value-of select="bgcolor"/></xsl:attribute>
			</xsl:if>
			<img width="145" height="200" vspace="0">
				<xsl:attribute name="src">
					<xsl:value-of select="$imagesFolder"/>agent_002_<xsl:value-of select="agent"/>.gif
				</xsl:attribute>
			</img>
		</td>
	</tr>
</table>
</xsl:template>
</xsl:stylesheet>
