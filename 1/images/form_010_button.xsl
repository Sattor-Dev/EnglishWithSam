<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	form_010_button.xsl
'*	Copyright (c) Websoft, 2006.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="objectID"></xsl:param>
<!--		 Template: Root    -->
<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>
<!--		 Template: Params    --> 
<xsl:template match="params">
	<input type="button">
		<xsl:attribute name="value"><xsl:value-of select="input_text" /></xsl:attribute>
		<xsl:variable name="cur_align" select="input_text_align" />
		<xsl:variable name="cur_font" select="input_font" />
		<xsl:variable name="cur_font_weight" select="input_font_weight" />
		<xsl:variable name="cur_font_style" select="input_font_style" />
		<xsl:variable name="cur_font_size" select="input_font_size" />
		<xsl:variable name="cur_font_color" select="input_font_color" />
		<xsl:variable name="cur_border_style" select="input_border_style" />
		<xsl:variable name="cur_border_width" select="input_border_width" />
		<xsl:variable name="cur_border_color" select="input_border_color" />
		<xsl:variable name="cur_bg_color" select="input_bg_color" />
		<xsl:variable name="cur_style" select="concat('position: relative; width: 100%; height: 100%; font-family:',$cur_font,'; color: ',$cur_font_color,'; font-weight: ',$cur_font_weight,'; font-style: ',$cur_font_style,'; font-size:', $cur_font_size,'px; text-align: ', $cur_align,'; border: ',$cur_border_width,'px ',$cur_border_color,' ',$cur_border_style,'; background-color: ',$cur_bg_color,';')" />
		<xsl:attribute name="style"><xsl:copy-of select="$cur_style" />; cursor: hand; cursor: pointer;</xsl:attribute>
	</input>
</xsl:template>
</xsl:stylesheet>
