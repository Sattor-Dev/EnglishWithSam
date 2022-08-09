<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:websoft="http://www.websoft.ru" version="1.0">
<!--
'*	009_storage#.xsl
'*	Copyright (c) Websoft, 2013.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="objectID"></xsl:param>

<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>

<xsl:template match="params">
    <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
        <tr>
            <td>
                <xsl:attribute name="style">border: #00c 1px dotted</xsl:attribute>
                <div style="font-family: Verdana, Arial, sans-serif; font-size:10px; color: #999999; text-align:center"><xsl:value-of select="hidden.label.1"/><br/><xsl:value-of select="hidden.label.2"/></div>
            </td>
      </tr>
    </table>
</xsl:template>

</xsl:stylesheet>
