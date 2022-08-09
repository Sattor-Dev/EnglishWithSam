<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	003_blocklist#.xsl
'*	Copyright (c) Websoft, 2007.  All rights reserved.
-->

<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>

<xsl:param name="objectID"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="moduleImagesFolder"></xsl:param>

<!-- profiles definition start -->
<xsl:variable name="profile">
	<common>
		<blank>
			<src>1blank.gif</src>
			<width>1</width>
			<height>1</height>
		</blank>
	</common>
		<corner_top_left>
			<src>list_cor_tl.gif</src>
			<width>40</width>
			<height>10</height>
		</corner_top_left>
		<corner_top_right>
			<src>list_cor_tr.gif</src>
			<width>10</width>
			<height>10</height>
		</corner_top_right>
		<corner_bottom_left>
			<src>list_cor_bl.gif</src>
			<width>40</width>
			<height>10</height>
		</corner_bottom_left>
		<corner_bottom_right>
			<src>list_cor_br.gif</src>
			<width>10</width>
			<height>10</height>
		</corner_bottom_right>
		<item_1>
			<src>list_item_1.gif</src>
			<width>40</width>
			<height>25</height>
		</item_1>
		<item_2>
			<src>list_item_2.gif</src>
			<width>40</width>
			<height>25</height>
		</item_2>
		<item_3>
			<src>list_item_3.gif</src>
			<width>40</width>
			<height>25</height>
		</item_3>
		<item_4>
			<src>list_item_4.gif</src>
			<width>40</width>
			<height>25</height>
		</item_4>
		<item_5>
			<src>list_item_5.gif</src>
			<width>40</width>
			<height>25</height>
		</item_5>
		<item_6>
			<src>list_item_6.gif</src>
			<width>40</width>
			<height>25</height>
		</item_6>
		<item_7>
			<src>list_item_7.gif</src>
			<width>40</width>
			<height>25</height>
		</item_7>
		<item_8>
			<src>list_item_8.gif</src>
			<width>40</width>
			<height>25</height>
		</item_8>
		<item_9>
			<src>list_item_9.gif</src>
			<width>40</width>
			<height>25</height>
		</item_9>
		<item_bomb>
			<src>list_item_bomb.gif</src>
			<width>40</width>
			<height>25</height>
		</item_bomb>
		<item_qu>
			<src>list_item_qu.gif</src>
			<width>40</width>
			<height>25</height>
		</item_qu>
		<item_att>
			<src>list_item_att.gif</src>
			<width>40</width>
			<height>25</height>
		</item_att>
		<item_att_red>
			<src>list_item_att_red.gif</src>
			<width>40</width>
			<height>25</height>
		</item_att_red>
		<item_ok>
			<src>list_item_ok.gif</src>
			<width>40</width>
			<height>25</height>
		</item_ok>
		<item_eye>
			<src>list_item_eye.gif</src>
			<width>40</width>
			<height>25</height>
		</item_eye>
		<item_star>
			<src>list_item_star.gif</src>
			<width>40</width>
			<height>25</height>
		</item_star>
		<item_in>
			<src>list_item_in.gif</src>
			<width>40</width>
			<height>25</height>
		</item_in>
		<item_drop>
			<src>list_item_drop.gif</src>
			<width>40</width>
			<height>25</height>
		</item_drop>
		<item_frown>
			<src>list_item_frown.gif</src>
			<width>40</width>
			<height>25</height>
		</item_frown>
		<item_snow>
			<src>list_item_snow.gif</src>
			<width>40</width>
			<height>25</height>
		</item_snow>
		<item_pointer>
			<src>list_item_pointer.gif</src>
			<width>40</width>
			<height>25</height>
		</item_pointer>
		<item_smile>
			<src>list_item_smile.gif</src>
			<width>40</width>
			<height>25</height>
		</item_smile>
		<item_scull>
			<src>list_item_scull.gif</src>
			<width>40</width>
			<height>25</height>
		</item_scull>
		<item_nav>
			<src>list_item_nav.gif</src>
			<width>40</width>
			<height>25</height>
		</item_nav>
		<background_top_edge><src>list_bg_t.gif</src></background_top_edge>
		<background_left_edge><src>list_bg_l.gif</src></background_left_edge>
		<background_right_edge><src>list_bg_r.gif</src></background_right_edge>
		<background_bottom_edge><src>list_bg_b.gif</src></background_bottom_edge>
</xsl:variable>
<!-- profiles definition end -->
<!--		 Template: Root    -->
<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>
<!--		 Template: Params    -->
<xsl:template match="params">

	<xsl:variable name="cur_profile" select="listblock_profile"/>
	<xsl:variable name="cur_folder"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="$cur_profile"/>\</xsl:variable>
	<xsl:variable name="cur_mark" select="blocklist_mark" />
	<xsl:for-each select="table/item">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
				<xsl:variable name="cur_count" select="position()" />
				<xsl:variable name="item_id" select="concat($objectID,'_',$cur_count)" />
				<xsl:variable name="cur_itemnumber" select="concat('item_',$cur_count)" />
				<xsl:variable name="cur_itempic" select="concat('item_',$cur_mark)" />
				<xsl:attribute name="id"><xsl:value-of select="$item_id"/></xsl:attribute>
				<xsl:attribute name="style">margin-bottom:<xsl:value-of select="../../items_margin"/>px;</xsl:attribute>
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
					<div id="itemInnerText">
						<xsl:variable name="cur_margin" select="../../blocklist_margin" />
						<xsl:variable name="cur_style" select="concat('cursor:default; position: relative; margin: ',$cur_margin,'px;')" />
						<xsl:attribute name="style"><xsl:value-of select="$cur_style" /></xsl:attribute>
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

	<xsl:if test="on_link='yes'">
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
				<xsl:attribute name="onclick">var oArgs=new Object; oArgs.pid='<xsl:value-of select="$objectID"/>'; CallMethod('002_blocklist', 'ShowItem',oArgs); return false;</xsl:attribute>
				<xsl:value-of select="link_text" disable-output-escaping="yes"/>
			</a>
		</div>
	</xsl:if>
	<xsl:if test="on_button='yes'">
		<xsl:if test="standard='yes'">
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
					<xsl:attribute name="onclick">var oArgs=new Object; oArgs.pid='<xsl:value-of select="$objectID"/>'; CallMethod('002_blocklist', 'ShowItem',oArgs); return false;</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="button_text"/></xsl:attribute>
				</input>
			</div>
		</xsl:if>
		<xsl:if test="standard!='yes'">
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
					<xsl:attribute name="src"><xsl:value-of select="substring-before($moduleImagesFolder,'images\')"/><xsl:value-of select="translate(next_img,'/','\')"/></xsl:attribute>
				</img>
			</div>
		</xsl:if>
	</xsl:if>

</xsl:template>
</xsl:stylesheet>
