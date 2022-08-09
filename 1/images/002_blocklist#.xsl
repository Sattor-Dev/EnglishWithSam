<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	002_blocklist#.xsl
'*	Copyright (c) Websoft, 2007.  All rights reserved.
-->

<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>

<xsl:param name="objectID"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="moduleImagesFolder"></xsl:param>

<!--		 Template: Root    -->
<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>
<!--		 Template: Params    -->
<xsl:template match="params">

<xsl:for-each select="list/item">
	<table width="100%" cellpadding="0" cellspacing="0">
		<xsl:if test="position()!=1"><xsl:attribute name="style">margin-top: <xsl:value-of select="../../items_margin"/>px</xsl:attribute></xsl:if>
		<tr>
			<td width="100%">
				<xsl:attribute name="style">padding: <xsl:value-of select="margin"/>px; border-color: <xsl:value-of select="bordercolor"/>; border-width: <xsl:value-of select="borderwidth"/>px; border-style: <xsl:value-of select="borderstyle"/>; background-color: <xsl:value-of select="bgcolor"/>;</xsl:attribute>
				<div>
					<xsl:value-of select="itemtext" disable-output-escaping="yes"/>
				</div>
			</td>
		</tr>
	</table>
</xsl:for-each>

<xsl:if test="mode='click'">
	<xsl:if test="click_mode='link'">
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_nextbutton</xsl:attribute>
			<xsl:attribute name="style">
				margin-top: <xsl:value-of select="items_margin"/>px;
				width: 100%;
				padding-right: 3px;
				padding-left: 3px;
				text-align: <xsl:value-of select="btn_align"/>;
				display: inline;
			</xsl:attribute>
			<a href="#">
				<xsl:attribute name="onclick">var oArgs=new Object; oArgs.pid='<xsl:value-of select="$objectID"/>'; CallMethod('002_blocklist', 'ShowItem',oArgs); return false;</xsl:attribute>
				<xsl:value-of select="link_text" disable-output-escaping="yes"/>
			</a>
		</div>
	</xsl:if>
	<xsl:if test="click_mode='button'">
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_nextbutton</xsl:attribute>
			<xsl:attribute name="style">
				margin-top: <xsl:value-of select="items_margin"/>px;
				width: 100%;
				padding-right: 3px;
				padding-left: 3px;
				text-align: <xsl:value-of select="btn_align"/>;
				display: inline;
			</xsl:attribute>
			<input type="button">
				<xsl:attribute name="style">
					border-style: <xsl:value-of select="input_border_style"/>;
					border-width: <xsl:value-of select="input_border_width"/>px;
					border-color: <xsl:value-of select="input_border_color"/>;
					background-color: <xsl:value-of select="input_bg_color"/>;
					font-family: <xsl:value-of select="input_font"/>;
					font-size: <xsl:value-of select="input_font_size"/>px;
					<xsl:if test="input_font_style='bitalic'">font-weight: bold; font-style: italic; </xsl:if>
					<xsl:if test="input_font_style='italic'">font-weight: normal; font-style: italic; </xsl:if>
					<xsl:if test="input_font_style='bold'">font-weight: bold; font-style: normal; </xsl:if>
					<xsl:if test="input_font_style='normal'">font-weight: normal; font-style: normal; </xsl:if>
					color: <xsl:value-of select="input_font_color"/>;
					text-align: <xsl:value-of select="input_text_align"/>;
				</xsl:attribute>
				<xsl:attribute name="onclick">var oArgs=new Object; oArgs.pid='<xsl:value-of select="$objectID"/>'; CallMethod('002_blocklist', 'ShowItem',oArgs); return false;</xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="button_text"/></xsl:attribute>
			</input>
		</div>
	</xsl:if>
	<xsl:if test="click_mode='image'">
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_nextbutton</xsl:attribute>
			<xsl:attribute name="style">
				margin-top: <xsl:value-of select="items_margin"/>px;
				width: 100%;
				padding-right: 3px;
				padding-left: 3px;
				text-align: <xsl:value-of select="btn_align"/>;
				display: inline;
			</xsl:attribute>
			<img border="0">
				<xsl:attribute name="src"><xsl:value-of select="next_img"/></xsl:attribute>
				<xsl:attribute name="style">cursor:hand; cursor:pointer;</xsl:attribute>
				<xsl:attribute name="onclick">var oArgs=new Object; oArgs.pid='<xsl:value-of select="$objectID"/>'; CallMethod('002_blocklist', 'ShowItem',oArgs); return false;</xsl:attribute>
			</img>
		</div>
	</xsl:if>
</xsl:if>

</xsl:template>
</xsl:stylesheet>
