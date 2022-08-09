<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	006_listitem#.xsl
'*	Copyright (c) Websoft, 2006.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="imagesFolder"></xsl:param>
<!-- profiles definition start -->
<xsl:variable name="profiles">
	<common>
		<blank>
			<src>1blank.gif</src>
			<width>1</width>
			<height>1</height>
		</blank>
	</common>
	<profile>
		<standard>
			<item_1>
				<src>new_list_item_1.gif</src>
				<width>32</width>
				<height>32</height>
			</item_1>
			<item_2>
				<src>new_list_item_2.gif</src>
				<width>32</width>
				<height>32</height>
			</item_2>
			<item_3>
				<src>new_list_item_3.gif</src>
				<width>32</width>
				<height>32</height>
			</item_3>
			<item_4>
				<src>new_list_item_4.gif</src>
				<width>32</width>
				<height>32</height>
			</item_4>
			<item_5>
				<src>new_list_item_5.gif</src>
				<width>32</width>
				<height>32</height>
			</item_5>
			<item_6>
				<src>new_list_item_6.gif</src>
				<width>32</width>
				<height>32</height>
			</item_6>
			<item_7>
				<src>new_list_item_7.gif</src>
				<width>32</width>
				<height>32</height>
			</item_7>
			<item_8>
				<src>new_list_item_8.gif</src>
				<width>32</width>
				<height>32</height>
			</item_8>
			<item_9>
				<src>new_list_item_9.gif</src>
				<width>32</width>
				<height>32</height>
			</item_9>
			<item_ok>
				<src>new_list_item_ok.gif</src>
				<width>32</width>
				<height>32</height>
			</item_ok>
			<item_qu>
				<src>new_list_item_qu.gif</src>
				<width>32</width>
				<height>32</height>
			</item_qu>
			<item_att>
				<src>new_list_item_att.gif</src>
				<width>32</width>
				<height>32</height>
			</item_att>
			<item_drop>
				<src>new_list_item_drop.gif</src>
				<width>32</width>
				<height>32</height>
			</item_drop>
			<item_star>
				<src>new_list_item_star.gif</src>
				<width>32</width>
				<height>32</height>
			</item_star>
			<item_in>
				<src>new_list_item_in.gif</src>
				<width>32</width>
				<height>32</height>
			</item_in>
			<item_pointer>
				<src>new_list_item_pointer.gif</src>
				<width>32</width>
				<height>32</height>
			</item_pointer>
			<item_bomb>
				<src>new_list_item_bomb.gif</src>
				<width>32</width>
				<height>32</height>
			</item_bomb>
			<item_smile>
				<src>new_list_item_smile.gif</src>
				<width>32</width>
				<height>32</height>
			</item_smile>
			<item_frown>
				<src>new_list_item_frown.gif</src>
				<width>32</width>
				<height>32</height>
			</item_frown>
			<item_nav>
				<src>new_list_item_nav.gif</src>
				<width>32</width>
				<height>32</height>
			</item_nav>
			<item_eye>
				<src>new_list_item_eye.gif</src>
				<width>32</width>
				<height>32</height>
			</item_eye>
			<item_scull>
				<src>new_list_item_scull.gif</src>
				<width>32</width>
				<height>32</height>
			</item_scull>
			<bordercolor>#727272</bordercolor>
			<bgcolor>#CCDCFE</bgcolor>
		</standard>
	</profile>
</xsl:variable>
<!-- profiles definition end -->
<!--		 Template: Root    --> 
<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>
<!--		 Template: Params    --> 
<xsl:template match="params">
<xsl:variable name="cur_profile">standard</xsl:variable>
<xsl:variable name="cur_mark" select="listitem_mark" />
<xsl:variable name="cur_itempic" select="concat('item_',$cur_mark)" />
<table width="100%" cellpadding="0" cellspacing="0" style="border-collapse: collapse;">
  <tr>
 	<td valign="top">
  		<xsl:attribute name="style">border: 2px solid <xsl:value-of select="border_color" /></xsl:attribute>
		<img>
			<xsl:attribute name="vspace"><xsl:value-of select="listitem_margin" /></xsl:attribute>
			<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="msxsl:node-set($profiles)/profile/*[name(.)=$cur_profile]/*[name(.)=$cur_itempic]/src" /></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profiles)/profile/*[name(.)=$cur_profile]/*[name(.)=$cur_itempic]/width" /></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profiles)/profile/*[name(.)=$cur_profile]/*[name(.)=$cur_itempic]/height" /></xsl:attribute>
		</img>
	</td>
    <td width="100%">
 		<xsl:attribute name="style">border: 2px solid <xsl:value-of select="border_color" /></xsl:attribute>
		<xsl:if test="valign_top='yes'">
			<xsl:attribute name="valign">top</xsl:attribute>
		</xsl:if>
		<xsl:if test="valign_middle='yes'">
			<xsl:attribute name="valign">middle</xsl:attribute>
		</xsl:if>
		<xsl:if test="valign_bottom='yes'">
			<xsl:attribute name="valign">bottom</xsl:attribute>
		</xsl:if>
		<xsl:attribute name="bgcolor"><xsl:value-of select="fill_color"/></xsl:attribute>
		<div id="itemInnerText">
				<xsl:variable name="cur_margin" select="listitem_margin" />
				<xsl:variable name="cur_style" select="concat('cursor:default; position: relative; margin: ',$cur_margin,'px;')" />
				<xsl:attribute name="style"><xsl:value-of select="$cur_style" /></xsl:attribute>
				<xsl:value-of select="innerText" disable-output-escaping="yes"/>
		</div>
	</td>
  </tr>
</table>
</xsl:template>
</xsl:stylesheet>
