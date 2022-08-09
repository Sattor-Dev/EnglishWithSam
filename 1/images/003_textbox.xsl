<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	003_textbox.xsl
'*	Copyright (c) Websoft Ltd., Russia.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="moduleImagesFolder"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="width"></xsl:param>
<xsl:param name="height"></xsl:param>
<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">

	<xsl:variable name="padding.text">
		<xsl:choose>
			<xsl:when test="string(number(margin))='NaN'">6</xsl:when>
			<xsl:otherwise><xsl:value-of select="margin"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="border.width">
		<xsl:choose>
			<xsl:when test="string(number(borderwidth))='NaN'">3</xsl:when>
			<xsl:otherwise><xsl:value-of select="borderwidth"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="shadow.color">
		<xsl:choose>
			<xsl:when test="shadow_strength='extralight'">#CCCCCC</xsl:when>
			<xsl:when test="shadow_strength='light'">#999999</xsl:when>
			<xsl:when test="shadow_strength='dark'">#333333</xsl:when>
			<xsl:when test="shadow_strength='extradark'">#000000</xsl:when>
			<xsl:otherwise>#666666</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="shadow.string.w3c">
		<xsl:choose>
			<xsl:when test="shadow_strength='extralight'">2px 2px 6px #CCCCCC</xsl:when>
			<xsl:when test="shadow_strength='light'">2px 2px 6px #999999</xsl:when>
			<xsl:when test="shadow_strength='dark'">2px 2px 6px #333333</xsl:when>
			<xsl:when test="shadow_strength='extradark'">2px 2px 6px #000000</xsl:when>
			<xsl:otherwise>2px 2px 6px #666666</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_div</xsl:attribute>
		<xsl:attribute name="style"><xsl:if test="shadow='yes'">-moz-box-shadow: <xsl:value-of select="$shadow.string.w3c"/>; -webkit-box-shadow: <xsl:value-of select="$shadow.string.w3c"/>; box-shadow: <xsl:value-of select="$shadow.string.w3c"/>; filter: progid:DXImageTransform.Microsoft.Shadow(color=<xsl:value-of select="$shadow.color"/>,direction=135, strength=5); </xsl:if>box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box; width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; padding: <xsl:value-of select="$padding.text"/>px; background-color: <xsl:value-of select="bgcolor" />;<xsl:if test="borderstyle!='none'">border-color: <xsl:value-of select="bordercolor"/>; border-width: <xsl:value-of select="$border.width"/>px; border-style: <xsl:value-of select="borderstyle"/>;</xsl:if></xsl:attribute>
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_txt</xsl:attribute>
			<xsl:attribute name="style">width: <xsl:value-of select="number($width) - 2*number($padding.text) - 2*number($border.width)"/>px; height: <xsl:value-of select="number($height) - 2*number($padding.text) - 2*number($border.width)"/>px;
				<xsl:if test="overflow='fit'">overflow: visible</xsl:if>
				<xsl:if test="overflow='scroll'">overflow: scroll</xsl:if>
				<xsl:if test="overflow='scroll-y'">overflow-y: scroll; overflow-x: hidden;</xsl:if>
				<xsl:if test="overflow='scroll-x'">overflow-x: scroll; overflow-y: hidden;</xsl:if>
				<xsl:if test="overflow='auto'">overflow-x: hidden; overflow-y: auto;</xsl:if>
				<xsl:if test="overflow='hidden'">overflow: hidden;</xsl:if>
			</xsl:attribute>
			<xsl:value-of select="textbox_text" disable-output-escaping="yes"/>
		</div>
	</div>
	<xsl:if test="onclick_hide='yes'">
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_cover</xsl:attribute>	
			<xsl:attribute name="onclick">CallMethod("003_textbox", "Close", { pid: '<xsl:value-of select="$objectID"/>' }); return false;</xsl:attribute>
			<xsl:attribute name="style">cursor: pointer; position: absolute; top: 0px; left: 0px; width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; overflow: hidden; font-size: <xsl:choose><xsl:when test="number($height) &gt; number($width)"><xsl:value-of select="$height"/></xsl:when><xsl:otherwise><xsl:value-of select="$width"/></xsl:otherwise></xsl:choose>px;</xsl:attribute>
			&#160;
		</div>
	</xsl:if>

</xsl:template>
</xsl:stylesheet>
