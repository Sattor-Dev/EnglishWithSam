<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	001_textbox.xsl
'*	Copyright (c) Websoft, 2006.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="imagesFolder"></xsl:param>
<!--		 Template: Root    --> 
<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>
<!--		 Template: Params    --> 

<xsl:template match="params">
	<xsl:variable name="cur_bgcolor" select="box_backcolor"/>
	<xsl:variable name="cur_borderstyle" select="box_borderstyle"/>
	<xsl:variable name="cur_bordercolor" select="box_bordercolor"/>
	<xsl:variable name="cur_borderwidth" select="box_borderwidth"/>
	<xsl:variable name="cur_opacity" select="box_opacity"/>
	<xsl:variable name="cur_shadow" select="box_shadow"/>
	<xsl:variable name="cur_sx" select="box_shadow_x"/>
	<xsl:variable name="cur_sy" select="box_shadow_y"/>
	<xsl:variable name="cur_sopacity" select="box_shadow_opacity"/>
	<xsl:variable name="cur_scopy" select="box_shadow_copy"/>
	<xsl:variable name="cur_sbgcolor" select="box_shadow_backcolor"/>
	<xsl:variable name="cur_sborderstyle" select="box_shadow_borderstyle"/>
	<xsl:variable name="cur_sbordercolor" select="box_shadow_bordercolor"/>
	<xsl:variable name="cur_sborderwidth" select="box_shadow_borderwidth"/>
	<xsl:variable name="cur_style">position:absolute; width:90%; background-color: <xsl:value-of select="$cur_bgcolor"/>; layer-background-color: <xsl:value-of select="$cur_bgcolor"/>; border-width: <xsl:value-of select="$cur_borderwidth"/>px; border-style: <xsl:value-of select="$cur_borderstyle"/>; border-color: <xsl:value-of select="$cur_bordercolor"/>; left: 10px; top: 10px; 
		<xsl:if test="$cur_opacity!=100">
			filter:alpha(opacity=<xsl:value-of select="$cur_opacity"/>); -moz-opacity: 0.<xsl:value-of select="$cur_opacity"/>; opacity: 0.<xsl:value-of select="$cur_opacity"/>;
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="cur_sstyle">position:absolute; width:90%;
		<xsl:choose>
			<xsl:when test="$cur_scopy='yes'">
				background-color: <xsl:value-of select="$cur_bgcolor"/>; layer-background-color: <xsl:value-of select="$cur_bgcolor"/>; border-width: <xsl:value-of select="$cur_borderwidth"/>px; border-style: <xsl:value-of select="$cur_borderstyle"/>; border-color: <xsl:value-of select="$cur_bordercolor"/>; left: <xsl:value-of select="number($cur_sx+10)"/>px; top: <xsl:value-of select="number($cur_sy+10)"/>px; 
			</xsl:when>
			<xsl:otherwise>
				background-color: <xsl:value-of select="$cur_sbgcolor"/>; layer-background-color: <xsl:value-of select="$cur_sbgcolor"/>; border-width: <xsl:value-of select="$cur_sborderwidth"/>px; border-style: <xsl:value-of select="$cur_sborderstyle"/>; border-color: <xsl:value-of select="$cur_sbordercolor"/>; left: <xsl:value-of select="number($cur_sx+10)"/>px; top: <xsl:value-of select="number($cur_sy+10)"/>px; 
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="$cur_sopacity!=100">
			filter:alpha(opacity=<xsl:value-of select="$cur_sopacity"/>); -moz-opacity: 0.<xsl:value-of select="$cur_sopacity"/>; opacity: 0.<xsl:value-of select="$cur_sopacity"/>;
		</xsl:if>
	</xsl:variable>
	<xsl:if test="$cur_shadow='yes'">
		<div>
			<xsl:attribute name="style"><xsl:value-of select="$cur_sstyle"/></xsl:attribute>
			<table width="100%" cellspacing="0" border="0">
				<xsl:attribute name="cellpadding"><xsl:value-of select="box_margin"/></xsl:attribute>
				<tr>
					<td valign="top">
						<xsl:value-of select="box_text" disable-output-escaping="yes"/>
					</td>
				</tr>
			</table>
		</div>
	</xsl:if>
	<div>
		<xsl:attribute name="style"><xsl:value-of select="$cur_style"/></xsl:attribute>
			<table width="100%" cellspacing="0" border="0">
				<xsl:attribute name="cellpadding"><xsl:value-of select="box_margin"/></xsl:attribute>
				<tr>
					<td valign="top">
						<xsl:value-of select="box_text" disable-output-escaping="yes"/>
					</td>
				</tr>
			</table>
	</div>
</xsl:template>
</xsl:stylesheet>
