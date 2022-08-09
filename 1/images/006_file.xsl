<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	006_file.xsl
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
<xsl:variable name="cur_type"><xsl:value-of select="file_controls"/></xsl:variable>
<xsl:variable name="cur_uri"><xsl:value-of select="file_uri"/></xsl:variable>
<xsl:variable name="cur_link"><xsl:value-of select="file_link"/></xsl:variable>
<xsl:variable name="cur_piclink"><xsl:value-of select="pic_link"/></xsl:variable>
<table width="100%" cellpadding="3" cellspacing="0" border="0">
	<tr>
		<xsl:if test="$cur_type='left'">
			<td width="100%" align="right" valign="middle">
				<xsl:if test="$cur_link='yes'">
					<xsl:attribute name="onclick">window.open('<xsl:value-of select="file_uri" />');return false;</xsl:attribute>
					<xsl:attribute name="style">cursor:pointer;</xsl:attribute>
				</xsl:if>
				<xsl:if test="file_underline='yes' and file_link='yes'"><a href="javascript:void(0)"><xsl:value-of select="file_text" disable-output-escaping="yes"/></a></xsl:if>
				<xsl:if test="file_underline='no' or file_link='no'"><xsl:value-of select="file_text" disable-output-escaping="yes"/></xsl:if>
			</td>
		</xsl:if>
		<td align="center" valign="top">
			<img width="32" height="32" border="0" style="cursor:pointer;">
				<xsl:if test="$cur_piclink='yes'">
					<xsl:attribute name="onclick">window.open('<xsl:value-of select="file_uri" />');return false;</xsl:attribute>
					<xsl:attribute name="style">cursor:pointer;</xsl:attribute>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="contains($cur_uri,'.doc') or contains($cur_uri,'.DOC')">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>icon_doc.gif</xsl:attribute>
					</xsl:when>
					<xsl:when test="contains($cur_uri,'.xls') or contains($cur_uri,'.XLS')">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>icon_xls.gif</xsl:attribute>
					</xsl:when>
					<xsl:when test="contains($cur_uri,'.htm') or contains($cur_uri,'.HTM')">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>icon_html.gif</xsl:attribute>
					</xsl:when>
					<xsl:when test="contains($cur_uri,'.pdf') or contains($cur_uri,'.PDF')">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>icon_pdf.gif</xsl:attribute>
					</xsl:when>
					<xsl:when test="contains($cur_uri,'.jpg') or contains($cur_uri,'.JPG')">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>icon_jpg.gif</xsl:attribute>
					</xsl:when>
					<xsl:when test="contains($cur_uri,'.gif') or contains($cur_uri,'.GIF')">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>icon_gif.gif</xsl:attribute>
					</xsl:when>
					<xsl:when test="contains($cur_uri,'.swf') or contains($cur_uri,'.SWF')">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>icon_swf.gif</xsl:attribute>
					</xsl:when>
					<xsl:when test="contains($cur_uri,'.zip') or contains($cur_uri,'.ZIP')">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>icon_zip.gif</xsl:attribute>
					</xsl:when>
					<xsl:when test="contains($cur_uri,'.rar') or contains($cur_uri,'.RAR')">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>icon_rar.gif</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>icon_txt.gif</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
		<xsl:if test="$cur_type='right'">
			<td width="100%" align="left" valign="middle">
				<xsl:if test="$cur_link='yes'">
					<xsl:attribute name="onclick">window.open('<xsl:value-of select="file_uri" />');return false;</xsl:attribute>
					<xsl:attribute name="style">cursor:pointer;</xsl:attribute>
				</xsl:if>
				<xsl:if test="file_underline='yes' and file_link='yes'"><a href="javascript:void(0)"><xsl:value-of select="file_text" disable-output-escaping="yes"/></a></xsl:if>
				<xsl:if test="file_underline='no' or file_link='no'"><xsl:value-of select="file_text" disable-output-escaping="yes"/></xsl:if>
			</td>
		</xsl:if>
	</tr>
	<xsl:if test="$cur_type='bottom'">
	<tr>
		<td width="100%" align="center" valign="top">
			<xsl:if test="$cur_link='yes'">
				<xsl:attribute name="onclick">window.open('<xsl:value-of select="file_uri" />');return false;</xsl:attribute>
				<xsl:attribute name="style">cursor:pointer;</xsl:attribute>
			</xsl:if>
			<xsl:if test="file_underline='yes' and file_link='yes'"><a href="javascript:void(0)"><xsl:value-of select="file_text" disable-output-escaping="yes"/></a></xsl:if>
			<xsl:if test="file_underline='no' or file_link='no'"><xsl:value-of select="file_text" disable-output-escaping="yes"/></xsl:if>
		</td>
	</tr>
	</xsl:if>
</table>
</xsl:template>
</xsl:stylesheet>
