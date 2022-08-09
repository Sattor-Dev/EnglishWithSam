<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	001_blocklist.xsl
'*	Copyright (c) Websoft, 2007.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<!--		 Template: Root    -->
<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>
<!--		 Template: Params    -->

<xsl:template match="params">

<xsl:for-each select="list/item">
	<table width="100%" cellpadding="0" cellspacing="0">
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_<xsl:value-of select="position()"/></xsl:attribute>
		<xsl:if test="../../eff='yes'">
			<xsl:attribute name="style">display: none; visibility: hidden; filter:revealtrans(duration=<xsl:value-of select="../../durat"/>, transition=<xsl:value-of select="../../trans"/>)</xsl:attribute>
		</xsl:if>
		<xsl:if test="../../eff='no'">
			<xsl:attribute name="style">display: none; visibility: hidden; </xsl:attribute>
		</xsl:if>
		<tr>
			<td width="100%">
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_td_<xsl:value-of select="position()"/></xsl:attribute>
				<xsl:attribute name="style">
					<xsl:if test="../../borderstyle!='none'">
						<xsl:choose>
							<xsl:when test="position()=1">
								<xsl:if test="../../firstlast='yes'">
									border-top-color: <xsl:value-of select="../../bordercolor"/>;
									border-top-width: <xsl:value-of select="../../borderwidth"/>px;
									border-top-style: <xsl:value-of select="../../borderstyle"/>;
									border-bottom-color: <xsl:value-of select="../../bordercolor"/>;
									border-bottom-width: <xsl:value-of select="../../borderwidth"/>px;
									border-bottom-style: <xsl:value-of select="../../borderstyle"/>;
								</xsl:if>
							</xsl:when>
							<xsl:when test="position()=last()">
								<xsl:if test="../../firstlast='yes'">
									border-bottom-color: <xsl:value-of select="../../bordercolor"/>;
									border-bottom-width: <xsl:value-of select="../../borderwidth"/>px;
									border-bottom-style: <xsl:value-of select="../../borderstyle"/>;
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								border-bottom-color: <xsl:value-of select="../../bordercolor"/>;
								border-bottom-width: <xsl:value-of select="../../borderwidth"/>px;
								border-bottom-style: <xsl:value-of select="../../borderstyle"/>;
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					background-color: <xsl:value-of select="bgcolor"/>;
				</xsl:attribute>
				<table width="100%" cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top">
							<xsl:attribute name="style">padding: <xsl:value-of select="margin"/>px;</xsl:attribute>
							<img border="0">
								<xsl:if test="default_bullet='yes'">
									<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="i_bullet"/>.gif</xsl:attribute>
								</xsl:if>
								<xsl:if test="default_bullet='no'">
									<xsl:attribute name="src"><xsl:value-of select="i_image"/></xsl:attribute>
								</xsl:if>
							</img>
						</td>
						<td width="100%">
							<xsl:attribute name="style">padding: <xsl:value-of select="margin"/>px;</xsl:attribute>
							<div>
								<xsl:value-of select="itemtext" disable-output-escaping="yes"/>
							</div>
						</td>
					</tr>
				</table>
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
				<xsl:attribute name="onclick">var oArgs=new Object; oArgs.pid='<xsl:value-of select="$objectID"/>'; CallMethod('001_blocklist', 'NextItem',oArgs); return false;</xsl:attribute>
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
				<xsl:attribute name="onclick">var oArgs=new Object; oArgs.pid='<xsl:value-of select="$objectID"/>'; CallMethod('001_blocklist', 'NextItem',oArgs); return false;</xsl:attribute>
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
				<xsl:attribute name="onclick">var oArgs=new Object; oArgs.pid='<xsl:value-of select="$objectID"/>'; CallMethod('001_blocklist', 'NextItem',oArgs); return false;</xsl:attribute>
			</img>
		</div>
	</xsl:if>
</xsl:if>

<!--
<xsl:for-each select="table/item">
	<xsl:variable name="cur_itemnumber" select="concat('item_',position())" />
	<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_item_<xsl:value-of select="position()"/></xsl:attribute>
		<xsl:attribute name="style">margin-bottom:<xsl:value-of select="../../items_margin"/>px;</xsl:attribute>
		<xsl:if test="../../eff='yes'">
			<xsl:attribute name="style">visibility:hidden; margin-bottom:<xsl:value-of select="../../items_margin"/>px; filter:revealtrans(duration=<xsl:value-of select="../../durat"/>, transition=<xsl:value-of select="../../trans"/>)</xsl:attribute>
		</xsl:if>
		<xsl:if test="../../eff='no'">
			<xsl:attribute name="style">visibility:hidden; margin-bottom:<xsl:value-of select="../../items_margin"/>px;</xsl:attribute>
		</xsl:if>
		<tr>
			<td>
				<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/width"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/height"/></xsl:attribute>
				<img>
					<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/src"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/height"/></xsl:attribute>
				</img>
			</td>
			<td width="100%">
				<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_top_edge/src"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/background_top_edge/height"/></xsl:attribute>
				<img>
					<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_top_edge/src"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/background_top_edge/width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/background_top_edge/height"/></xsl:attribute>
				</img>
			</td>
			<td>
				<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_top_right/width"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_top_right/height"/></xsl:attribute>
				<img>
					<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/corner_top_right/src"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_top_right/width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_top_right/height"/></xsl:attribute>
				</img>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/width" /></xsl:attribute>
				<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_left_edge/src"/></xsl:attribute>
				<img>
						<xsl:choose>
							<xsl:when test="$cur_mark='number'">
								<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/*[name(.)=$cur_itemnumber]/src" /></xsl:attribute>
								<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/*[name(.)=$cur_itemnumber]/width" /></xsl:attribute>
								<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/*[name(.)=$cur_itemnumber]/height" /></xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/*[name(.)=$cur_itempic]/src" /></xsl:attribute>
								<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/*[name(.)=$cur_itempic]/width" /></xsl:attribute>
								<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/*[name(.)=$cur_itempic]/height" /></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
				</img>
			</td>
			<td width="100%" bgcolor="#FFFFFF">
				<div>
					<xsl:attribute name="style">cursor: default; position: static; margin: <xsl:value-of select="../../blocklist_margin" />px;</xsl:attribute>
					<xsl:value-of select="innerText" disable-output-escaping="yes"/>
				</div>
			</td>
			<td width="100%">
				<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_right_edge/src"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/background_right_edge/height"/></xsl:attribute>
				<img>
					<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_right_edge/src"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/background_right_edge/width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/background_right_edge/height"/></xsl:attribute>
				</img>
			</td>
		</tr>
		<tr>
			<td>
				<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/width"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/height"/></xsl:attribute>
				<img>
					<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/src"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/height"/></xsl:attribute>
				</img>
			</td>
			<td width="100%">
				<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_bottom_edge/src"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/background_bottom_edge/height"/></xsl:attribute>
				<img>
					<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_bottom_edge/src"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/background_bottom_edge/width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/background_bottom_edge/height"/></xsl:attribute>
				</img>
			</td>
			<td>
				<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_right/width"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_right/height"/></xsl:attribute>
				<img>
					<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_right/src"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_right/width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_right/height"/></xsl:attribute>
				</img>
			</td>
		</tr>
	</table>
</xsl:for-each>
<xsl:if test="auto='no'">
				<xsl:if test="on_link='yes'">
					<div>
						<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_nextbutton</xsl:attribute>
						<xsl:attribute name="style">width:100%; padding:3px; text-align:right; display: none;</xsl:attribute>
						<a href="#">
							<xsl:attribute name="onclick">var a=new Object; a.pid='<xsl:value-of select="$objectID"/>'; CallMethod('003_blocklist', 'ShowItem',a); return false;</xsl:attribute>
							<xsl:value-of select="link_text" disable-output-escaping="yes"/>
						</a>
					</div>
				</xsl:if>
				<xsl:if test="on_button='yes'">
					<xsl:if test="standard='yes'">
						<div>
							<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_nextbutton</xsl:attribute>
							<xsl:attribute name="style">width:100%; padding:3px; text-align:right; display: none;</xsl:attribute>
							<input type="button">
								<xsl:attribute name="onclick">var a=new Object; a.pid='<xsl:value-of select="$objectID"/>'; CallMethod('003_blocklist', 'ShowItem',a); return false;</xsl:attribute>
								<xsl:attribute name="value"><xsl:value-of select="button_text"/></xsl:attribute>
							</input>
						</div>
					</xsl:if>
					<xsl:if test="standard='no'">
						<div>
							<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_nextbutton</xsl:attribute>
							<xsl:attribute name="style">width:100%; padding:3px; text-align:right; display: none;</xsl:attribute>
							<img border="0">
								<xsl:attribute name="src"><xsl:value-of select="next_img"/></xsl:attribute>
								<xsl:attribute name="style">cursor:hand; cursor:pointer;</xsl:attribute>
								<xsl:attribute name="onclick">var a=new Object; a.pid='<xsl:value-of select="$objectID"/>'; CallMethod('003_blocklist', 'ShowItem',a); return false;</xsl:attribute>
							</img>
						</div>
					</xsl:if>
				</xsl:if>
</xsl:if>-->
</xsl:template>
</xsl:stylesheet>
