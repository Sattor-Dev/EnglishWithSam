<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	nav_012_close.xsl
'*	Copyright (c) Websoft, 2007.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>
<xsl:template match="params">

	<xsl:variable name="object.template">nav_012_close</xsl:variable>
	<xsl:if test="sound.enabled='yes' and (sound.scheme='over' or sound.scheme='overclick') and sound.file.over='custom'">
		<div style="display: none;"><xsl:attribute name="preload"><xsl:value-of select="sound.file.over.user"/></xsl:attribute>.</div>
	</xsl:if>
	<xsl:if test="sound.enabled='yes' and (sound.scheme='click' or sound.scheme='overclick') and sound.file.click='custom'">
		<div style="display: none;"><xsl:attribute name="preload"><xsl:value-of select="sound.file.click.user"/></xsl:attribute>.</div>
	</xsl:if>

	<div style="display:none;">
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_storage</xsl:attribute>
		<img border="0">
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_img_0</xsl:attribute>
			<xsl:if test="standard='yes'">
				<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>ws_close_0.gif</xsl:attribute>
			</xsl:if>
			<xsl:if test="standard='no'">
				<xsl:attribute name="src"><xsl:value-of select="n1_img"/></xsl:attribute>
			</xsl:if>
		</img>
		<img border="0">
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_img_1</xsl:attribute>
			<xsl:if test="standard='yes'">
				<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>ws_close_1.gif</xsl:attribute>
			</xsl:if>
			<xsl:if test="standard='no'">
				<xsl:attribute name="src"><xsl:value-of select="n2_img"/></xsl:attribute>
			</xsl:if>
		</img>
		<img border="0">
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_img_2</xsl:attribute>
			<xsl:if test="standard='yes'">
				<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>ws_close_2.gif</xsl:attribute>
			</xsl:if>
			<xsl:if test="standard='no'">
				<xsl:attribute name="src"><xsl:value-of select="n3_img"/></xsl:attribute>
			</xsl:if>
		</img>
	</div>

	<img border="0" style="display:inline; z-index:900; cursor: pointer;">
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_CloseImg</xsl:attribute>
		<xsl:attribute name="src">
			<xsl:if test="standard='yes'"><xsl:value-of select="$imagesFolder"/>ws_close_0.gif</xsl:if>
			<xsl:if test="standard='no'"><xsl:value-of select="n1_img"/></xsl:if>
		</xsl:attribute>
		<xsl:attribute name="alt"><xsl:value-of select="alt_enabled"/></xsl:attribute>
		<xsl:attribute name="onmouseover">CallMethod('<xsl:value-of select="$object.template"/>', 'Over', { pid: '<xsl:value-of select="$objectID"/>', btn: this, rep: '_img_1' }); return false;</xsl:attribute>
		<xsl:attribute name="onmouseout">CallMethod('<xsl:value-of select="$object.template"/>', 'Out', { pid: '<xsl:value-of select="$objectID"/>', btn: this, rep: '_img_0' }); return false;</xsl:attribute>
		<xsl:attribute name="onmousedown">CallMethod('<xsl:value-of select="$object.template"/>', 'Down', { pid: '<xsl:value-of select="$objectID"/>', btn: this, rep: '_img_2' }); return false;</xsl:attribute>
		<xsl:attribute name="onmouseup">CallMethod('<xsl:value-of select="$object.template"/>', 'Click', { pid: '<xsl:value-of select="$objectID"/>' }); return false;</xsl:attribute>
	</img>

</xsl:template>
</xsl:stylesheet>
