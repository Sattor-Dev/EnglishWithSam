<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	009_storage.xsl
'*	Copyright (C) WebSoft Ltd. Russia. 
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
	<div style="display: none">
		<xsl:for-each select="files/item">
			<div><xsl:value-of select="file_uri" /></div>
		</xsl:for-each>
	</div>
</xsl:template>
</xsl:stylesheet>
