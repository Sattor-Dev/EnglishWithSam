<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	media_004_java.xsl 
'*	Copyright (c) Websoft, 2006.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="objectID"></xsl:param>
<!--		 Template: Root    -->
<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>
<!-- Template: Params --> 
<xsl:template match="params">
	<object type="application/x-java-applet" align="baseline">
		<xsl:attribute name="classid"><xsl:if test="jmachine='sun'">clsid:CAFEEFAC-0014-0002-0000-ABCDEFFEDCBA</xsl:if><xsl:if test="jmachine='msjvm'">clsid:clsid:08B0E5C0-4FCB-11CF-AAA5-00401C608501</xsl:if></xsl:attribute>
		<xsl:attribute name="id"><xsl:value-of select="$objectID" />_applet</xsl:attribute>
		<xsl:attribute name="width">100%</xsl:attribute>
		<xsl:attribute name="height">100%</xsl:attribute>
		<xsl:attribute name="alt"><xsl:value-of select="applet_alt" /></xsl:attribute>
		<xsl:if test="use_jar='no'">
			<param>
				<xsl:attribute name="name">code</xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="substring-after(class_uri,'/')"/></xsl:attribute>
			</param>
		</xsl:if>
		<xsl:if test="use_jar='yes'">
			<param>
				<xsl:attribute name="name">code</xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="class_start"/></xsl:attribute>
			</param>
			<param>
				<xsl:attribute name="name">archive</xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="substring-after(applet_uri,'/')"/></xsl:attribute>
			</param>
		</xsl:if>
		<param>
			<xsl:attribute name="name">codebase</xsl:attribute>
			<xsl:attribute name="value">images</xsl:attribute>
		</param>
		<param>
			<xsl:attribute name="name">type</xsl:attribute>
			<xsl:attribute name="value">application/x-java-applet</xsl:attribute>
		</param>
		<xsl:for-each select="param_list/item">
			<param>
				<xsl:attribute name="name"><xsl:value-of select="a_param/text()"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="a_param_value/text()"/></xsl:attribute>
			</param>
		</xsl:for-each>
		<comment>
			<applet align="baseline">
				<xsl:attribute name="id"><xsl:value-of select="$objectID" />_applet</xsl:attribute>
				<xsl:attribute name="width">100%</xsl:attribute>
				<xsl:attribute name="height">100%</xsl:attribute>
				<xsl:attribute name="alt"><xsl:value-of select="applet_alt" /></xsl:attribute>
				<xsl:if test="use_jar='no'">
					<param>
						<xsl:attribute name="name">code</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="substring-after(class_uri,'/')"/></xsl:attribute>
					</param>
				</xsl:if>
				<xsl:if test="use_jar='yes'">
					<param>
						<xsl:attribute name="name">code</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="class_start"/></xsl:attribute>
					</param>
					<param>
						<xsl:attribute name="name">archive</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="substring-after(applet_uri,'/')"/></xsl:attribute>
					</param>
				</xsl:if>
				<param>
					<xsl:attribute name="name">codebase</xsl:attribute>
					<xsl:attribute name="value">images</xsl:attribute>
				</param>
				<param>
					<xsl:attribute name="name">type</xsl:attribute>
					<xsl:attribute name="value">application/x-java-applet</xsl:attribute>
				</param>
				<xsl:for-each select="param_list/item">
					<param>
						<xsl:attribute name="name"><xsl:value-of select="a_param/text()"/></xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="a_param_value/text()"/></xsl:attribute>
					</param>
				</xsl:for-each>
			</applet>
		</comment>
	</object>
</xsl:template>
</xsl:stylesheet>
