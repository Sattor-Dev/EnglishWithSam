<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	media_005_flv#.xsl
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
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="100%" align="center" valign="middle" bgcolor="#EEEEEE">
			<img width="64" height="48" vspace="5">
				<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>media_005_flv.gif</xsl:attribute>
			</img>
			<div style="font-family: Verdana, Arial, sans-serif; font-size:10px;text-align:center; padding-top:12px">
				<xsl:if test="ffile='yes'">File: <xsl:value-of select="flash_uri" /></xsl:if>
				<xsl:if test="fURL='yes'">URL: <xsl:value-of select="flash_url" /></xsl:if>
			</div>
		</td>
	</tr>
	<xsl:if test="video_controls='full'">
		<tr>
			<td width="100%" align="center" valign="middle" bgcolor="#FFFFFF" height="16">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td><img width="20" height="16" border="0"><xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>btn_play.gif</xsl:attribute></img></td>
						<td width="100%"><xsl:attribute name="background"><xsl:value-of select="$imagesFolder"/>btn_bg.gif</xsl:attribute></td>
						<td><img width="20" height="16" border="0"><xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>btn_mute.gif</xsl:attribute></img></td>
					</tr>
				</table>
			</td>
		</tr>
	</xsl:if>
</table>
</xsl:template>
</xsl:stylesheet>
