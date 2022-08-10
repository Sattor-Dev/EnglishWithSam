<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	nav_011_sound.xsl
'*	Copyright (c) Websoft, 2007.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>
<xsl:template match="params">
	
	<xsl:variable name="object.template">nav_011_sound</xsl:variable>
	<xsl:if test="sound.enabled='yes' and (sound.scheme='over' or sound.scheme='overclick') and sound.file.over='custom'">
		<div style="display: none;"><xsl:attribute name="preload"><xsl:value-of select="sound.file.over.user"/></xsl:attribute>.</div>
	</xsl:if>
	<xsl:if test="sound.enabled='yes' and (sound.scheme='click' or sound.scheme='overclick') and sound.file.click='custom'">
		<div style="display: none;"><xsl:attribute name="preload"><xsl:value-of select="sound.file.click.user"/></xsl:attribute>.</div>
	</xsl:if>

	<div style="display:none;">
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_storage</xsl:attribute>
		<img border="0">
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_img_on_0</xsl:attribute>
			<xsl:if test="standard='yes'">
				<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="tabcolor"/>/btn_sound_on_0.gif</xsl:attribute>
			</xsl:if>
			<xsl:if test="standard='no'">
				<xsl:attribute name="src"><xsl:value-of select="n1_img"/></xsl:attribute>
			</xsl:if>
		</img>
		<img border="0">
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_img_on_1</xsl:attribute>
			<xsl:if test="standard='yes'">
				<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="tabcolor"/>/btn_sound_on_1.gif</xsl:attribute>
			</xsl:if>
			<xsl:if test="standard='no'">
				<xsl:attribute name="src"><xsl:value-of select="n2_img"/></xsl:attribute>
			</xsl:if>
		</img>
		<img border="0">
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_img_off_0</xsl:attribute>
			<xsl:if test="standard='yes'">
				<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="tabcolor"/>/btn_sound_off_0.gif</xsl:attribute>
			</xsl:if>
			<xsl:if test="standard='no'">
				<xsl:attribute name="src"><xsl:value-of select="n3_img"/></xsl:attribute>
			</xsl:if>
		</img>
		<img border="0">
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_img_off_1</xsl:attribute>
			<xsl:if test="standard='yes'">
				<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="tabcolor"/>/btn_sound_off_1.gif</xsl:attribute>
			</xsl:if>
			<xsl:if test="standard='no'">
				<xsl:attribute name="src"><xsl:value-of select="n4_img"/></xsl:attribute>
			</xsl:if>
		</img>
	</div>
	<div style="display:inline; z-index:900; cursor: pointer;">
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_sound_on</xsl:attribute>
		<img border="0">
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_simg_on</xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="alt_on"/></xsl:attribute>
			<xsl:attribute name="src">
				<xsl:if test="standard='yes'"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="tabcolor"/>/btn_sound_on_0.gif</xsl:if>
				<xsl:if test="standard='no'"><xsl:value-of select="n1_img"/></xsl:if>
			</xsl:attribute>
			<xsl:attribute name="onclick">CallMethod('<xsl:value-of select="$object.template"/>', 'Click', { pid: '<xsl:value-of select="$objectID"/>' }); return false;</xsl:attribute>
			<xsl:attribute name="onmouseover">CallMethod('<xsl:value-of select="$object.template"/>', 'Over', { pid: '<xsl:value-of select="$objectID"/>', btn: this, rep: '_img_on_1' }); return false;</xsl:attribute>
			<xsl:attribute name="onmouseout">CallMethod('<xsl:value-of select="$object.template"/>', 'Out', { pid: '<xsl:value-of select="$objectID"/>', btn: this, rep: '_img_on_0' }); return false;</xsl:attribute>
		</img>
	</div>
	<div style="display:none; z-index:901; cursor: pointer;">
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_sound_off</xsl:attribute>
		<img border="0">
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_simg_off</xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="alt_off"/></xsl:attribute>
			<xsl:attribute name="src">
				<xsl:if test="standard='yes'"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="tabcolor"/>/btn_sound_off_0.gif</xsl:if>
				<xsl:if test="standard='no'"><xsl:value-of select="n1_img"/></xsl:if>
			</xsl:attribute>
			<xsl:attribute name="onclick">CallMethod('<xsl:value-of select="$object.template"/>', 'Click', { pid: '<xsl:value-of select="$objectID"/>' }); return false;</xsl:attribute>
			<xsl:attribute name="onmouseover">CallMethod('<xsl:value-of select="$object.template"/>', 'Over', { pid: '<xsl:value-of select="$objectID"/>', btn: this, rep: '_img_off_1' }); return false;</xsl:attribute>
			<xsl:attribute name="onmouseout">CallMethod('<xsl:value-of select="$object.template"/>', 'Out', { pid: '<xsl:value-of select="$objectID"/>', btn: this, rep: '_img_off_0' }); return false;</xsl:attribute>
		</img>
	</div>
</xsl:template>
</xsl:stylesheet>
