<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	008_iframe#.xsl
'*	Copyright (c) Websoft, 2007.  All rights reserved.
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
		<xsl:attribute name="style">background-color: #EEEEEE; width: 100%; height: 100%;
		border-width: <xsl:value-of select="borderwidth"/>px; border-style: <xsl:value-of select="borderstyle"/>; border-color: <xsl:value-of select="bordercolor"/>;
		overflow: <xsl:if test="scrolling='no'">hidden</xsl:if><xsl:if test="scrolling!='no'">scroll</xsl:if>;
		</xsl:attribute>
		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td valign="middle" align="center">
					<img border="0">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>iframe_plc.gif</xsl:attribute>
					</img>
					<div style="padding-top: 12px; font-family: Verdana, Arial, sans-serif; font-size: 10px; text-align: center">
						External <xsl:if test="iURL='yes'">URL: <xsl:value-of select="url"/></xsl:if><xsl:if test="ifile='yes'">file: <xsl:value-of select="uri"/></xsl:if>
					</div>
				</td>
			</tr>
		</table>
	</div>
</xsl:template>
</xsl:stylesheet>
