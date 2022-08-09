<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	002_balloon#.xsl
'*	Copyright (c) Websoft, 2006.  All rights reserved.
-->

<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="imagesFolder"></xsl:param>

<!-- profiles definition start -->
<xsl:variable name="profile">
		<arrow_top_left>
			<src>balloon_arr_tl.gif</src>
			<width>40</width>
			<height>40</height>
		</arrow_top_left>
		<arrow_top_center>
			<src>balloon_arr_tc.gif</src>
			<width>40</width>
			<height>40</height>
		</arrow_top_center>
		<arrow_top_right>
			<src>balloon_arr_tr.gif</src>
			<width>40</width>
			<height>40</height>
		</arrow_top_right>
		<arrow_right_top>
			<src>balloon_arr_rt.gif</src>
			<width>40</width>
			<height>40</height>
		</arrow_right_top>
		<arrow_right_middle>
			<src>balloon_arr_rm.gif</src>
			<width>40</width>
			<height>40</height>
		</arrow_right_middle>
		<arrow_right_bottom>
			<src>balloon_arr_rb.gif</src>
			<width>40</width>
			<height>40</height>
		</arrow_right_bottom>
		<arrow_bottom_right>
			<src>balloon_arr_br.gif</src>
			<width>40</width>
			<height>40</height>
		</arrow_bottom_right>
		<arrow_bottom_center>
			<src>balloon_arr_bc.gif</src>
			<width>40</width>
			<height>40</height>
		</arrow_bottom_center>
		<arrow_bottom_left>
			<src>balloon_arr_bl.gif</src>
			<width>40</width>
			<height>40</height>
		</arrow_bottom_left>
		<arrow_left_bottom>
			<src>balloon_arr_lb.gif</src>
			<width>40</width>
			<height>40</height>
		</arrow_left_bottom>
			<arrow_left_middle>
			<src>balloon_arr_lm.gif</src>
			<width>40</width>
			<height>40</height>
		</arrow_left_middle>
		<arrow_left_top>
			<src>balloon_arr_lt.gif</src>
			<width>40</width>
			<height>40</height>
		</arrow_left_top>
		<corner_top_left>
			<src>balloon_tl.gif</src>
			<width>10</width>
			<height>10</height>
		</corner_top_left>
		<corner_top_right>
			<src>balloon_tr.gif</src>
			<width>10</width>
			<height>10</height>
		</corner_top_right>
		<corner_bottom_left>
			<src>balloon_bl.gif</src>
			<width>10</width>
			<height>10</height>
		</corner_bottom_left>
		<corner_bottom_right>
			<src>balloon_br.gif</src>
			<width>10</width>
			<height>10</height>
		</corner_bottom_right>
		<background_top_edge><src>balloon_bg_t.gif</src></background_top_edge>
		<background_right_edge><src>balloon_bg_r.gif</src></background_right_edge>
		<background_left_edge><src>balloon_bg_l.gif</src></background_left_edge>
		<background_bottom_edge><src>balloon_bg_b.gif</src></background_bottom_edge>
		<background><src>balloon_bg.gif</src></background>
		<innermargin>0</innermargin>
		<arrow_top_left>
			<id>ar_tl</id>
		</arrow_top_left>
		<arrow_top_center>
			<id>ar_tc</id>
		</arrow_top_center>
		<arrow_top_right>
			<id>ar_tr</id>
		</arrow_top_right>
		<arrow_right_top>
			<id>ar_rt</id>
		</arrow_right_top>
		<arrow_right_middle>
			<id>ar_rm</id>
		</arrow_right_middle>
		<arrow_right_bottom>
			<id>ar_rb</id>
		</arrow_right_bottom>
		<arrow_bottom_right>
			<id>ar_br</id>
		</arrow_bottom_right>
		<arrow_bottom_center>
			<id>ar_bc</id>
		</arrow_bottom_center>
		<arrow_bottom_left>
			<id>ar_bl</id>
		</arrow_bottom_left>
		<arrow_left_bottom>
			<id>ar_lb</id>
		</arrow_left_bottom>
		<arrow_left_middle>
			<id>ar_lm</id>
		</arrow_left_middle>
		<arrow_left_top>
			<id>ar_lt</id>
		</arrow_left_top>
</xsl:variable>

<!-- profiles definition end -->

<!--		 Template: Root    --> 

<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>

<!--		 Template: Params    --> 

<xsl:template match="params">
<xsl:variable name="cur_arrow" select="arrow"/>
<xsl:variable name="cur_profile" select="balloon_profile"/>
<xsl:variable name="cur_folder"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="$cur_profile"/>\</xsl:variable>
<xsl:variable name="blank"><xsl:value-of select="$imagesFolder"/>1blank.gif</xsl:variable>

<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr> 
		<td>
			<xsl:attribute name="width">1</xsl:attribute>
			<xsl:attribute name="height">1</xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
		<td>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/width"/></xsl:attribute>
			<xsl:attribute name="height">1</xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
		<td align="left">
			<xsl:attribute name="height">1</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_left/id"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='tl'">
						<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_top_left/src"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_left/width"/></xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_left/height"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
						<xsl:attribute name="width">1</xsl:attribute>
						<xsl:attribute name="height">1</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
		<td align="center">
			<xsl:attribute name="height">1</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_center/id"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='tc'">
						<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_top_center/src"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_center/width"/></xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_center/height"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
						<xsl:attribute name="width">1</xsl:attribute>
						<xsl:attribute name="height">1</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
 		<td align="right">
			<xsl:attribute name="height">1</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_right/id"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='tr'">
						<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_top_right/src"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_right/width"/></xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_right/height"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
						<xsl:attribute name="width">1</xsl:attribute>
						<xsl:attribute name="height">1</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
		<td>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/standard/corner_top_right/width"/></xsl:attribute>
			<xsl:attribute name="height">1</xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
		<td>	
			<xsl:attribute name="width">1</xsl:attribute>
			<xsl:attribute name="height">1</xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
	</tr>
	<tr> 
		<td>
			<xsl:attribute name="width">1</xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/height"/></xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
		<td>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/width"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/height"/></xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/src"/></xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/width"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/height"/></xsl:attribute>
			</img>
		</td>
		<td colspan="3">
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/height"/></xsl:attribute>
			<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_top_edge/src"/></xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
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
		<td>
			<xsl:attribute name="width">1</xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_top_right/height"/></xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
	</tr>
	<tr> 
		<td valign="top">
			<xsl:attribute name="width">1</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_top/id"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='lt'">
						<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_left_top/src"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_top/width"/></xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_top/height"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
						<xsl:attribute name="width">1</xsl:attribute>
						<xsl:attribute name="height">1</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
		<td rowspan="3">
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/width"/></xsl:attribute>
			<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_left_edge/src"/></xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
		<td colspan="3" rowspan="3">
			<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background/src"/></xsl:attribute>
			<div id="baseBalloonInside" style="position:relative; width:100%;">
				<table width="100%" cellspacing="0" border="0">
					<xsl:attribute name="cellpadding"><xsl:value-of select="msxsl:node-set($profile)/innermargin"/></xsl:attribute>
					<tr>
						<td valign="middle">
							<div id="baseBalloonText">
							<xsl:variable name="cur_margin" select="balloon_margin"/>
							<xsl:variable name="cur_innerstyle" select="concat('margin: ', $cur_margin,';')"/>
							<xsl:attribute name="style"><xsl:value-of select="$cur_innerstyle"/></xsl:attribute>
								<xsl:value-of select="balloon_text" disable-output-escaping="yes"/>
							</div>							
						</td>
					</tr>
				</table>
			</div>
		</td>
		<td rowspan="3">
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_top_right/width"/></xsl:attribute>
			<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_right_edge/src"/></xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
		<td valign="top">
			<xsl:attribute name="width">1</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_top/id"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='rt'">
						<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_right_top/src"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_top/width"/></xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_top/height"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
						<xsl:attribute name="width">1</xsl:attribute>
						<xsl:attribute name="height">1</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
	</tr>
	<tr> 
		<td valign="middle">
			<xsl:attribute name="width">1</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_middle/id"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='lm'">
						<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_left_middle/src"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_middle/width"/></xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_middle/height"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
						<xsl:attribute name="width">1</xsl:attribute>
						<xsl:attribute name="height">1</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
		<td valign="middle">
			<xsl:attribute name="width">1</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_middle/id"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='rm'">
						<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_right_middle/src"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_middle/width"/></xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_middle/height"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
						<xsl:attribute name="width">1</xsl:attribute>
						<xsl:attribute name="height">1</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
	</tr>
	<tr> 
		<td valign="bottom">
			<xsl:attribute name="width">1</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_bottom/id"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='lb'">
						<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_left_bottom/src"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_bottom/width"/></xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_bottom/height"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
						<xsl:attribute name="width">1</xsl:attribute>
						<xsl:attribute name="height">1</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
		<td valign="bottom">
			<xsl:attribute name="width">1</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_bottom/id"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='rb'">
						<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_right_bottom/src"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_bottom/width"/></xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_bottom/height"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
						<xsl:attribute name="width">1</xsl:attribute>
						<xsl:attribute name="height">1</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
	</tr>
	<tr> 
		<td>
			<xsl:attribute name="width">1</xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/height"/></xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
		<td>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/width"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/height"/></xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/src"/></xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/width"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/height"/></xsl:attribute>
			</img>
		</td>
		<td colspan="3">
			<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_bottom_edge/src"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/height"/></xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
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
		<td>
			<xsl:attribute name="width">1</xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_right/height"/></xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
	</tr>
	<tr> 
		<td>
			<xsl:attribute name="width">1</xsl:attribute>
			<xsl:attribute name="height">1</xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
		<td>
			<xsl:attribute name="height">1</xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/width"/></xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
		<td align="left">
			<xsl:attribute name="height">1</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_left/id"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='bl'">
						<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_left/src"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_left/width"/></xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_left/height"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
						<xsl:attribute name="width">1</xsl:attribute>
						<xsl:attribute name="height">1</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
		<td align="center">
			<xsl:attribute name="height">1</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_center/id"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='bc'">
						<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_center/src"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_center/width"/></xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_center/height"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
						<xsl:attribute name="width">1</xsl:attribute>
						<xsl:attribute name="height">1</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
		<td align="right">
			<xsl:attribute name="height">1</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_right/id"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='br'">
						<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_right/src"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_right/width"/></xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_right/height"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
						<xsl:attribute name="width">1</xsl:attribute>
						<xsl:attribute name="height">1</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</img>
		</td>
		<td>
			<xsl:attribute name="height">1</xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_right/width"/></xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
		<td>
			<xsl:attribute name="width">1</xsl:attribute>
			<xsl:attribute name="height">1</xsl:attribute>
			<img>
				<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
				<xsl:attribute name="width">1</xsl:attribute>
				<xsl:attribute name="height">1</xsl:attribute>
			</img>
		</td>
	</tr>
</table>
</xsl:template>

</xsl:stylesheet>
