<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	003_balloon.xsl
'*	Copyright (c) Websoft, 2006.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="imagesFolder"></xsl:param>
<!-- profiles definition start -->
<xsl:variable name="profile">
	<blank>
	<src>1blank.gif</src>
		<width>7</width>
		<height>7</height>
		<width_small>1</width_small>
		<height_small>1</height_small>
	</blank>
	<arrow_top_left>
	<src>balloon_arr_tl.gif</src>
		<width>26</width>
		<height>46</height>
	</arrow_top_left>
	<arrow_top_center>
		<src>balloon_arr_tc.gif</src>
		<width>26</width>
		<height>46</height>
	</arrow_top_center> 
	<arrow_top_right>
		<src>balloon_arr_tr.gif</src>
		<width>26</width>
		<height>46</height>
	</arrow_top_right>
	<arrow_right_top>
		<src>balloon_arr_rt.gif</src>
		<width>46</width>
		<height>26</height>
	</arrow_right_top>
	<arrow_right_middle>
		<src>balloon_arr_rm.gif</src>
		<width>46</width>
		<height>26</height>
	</arrow_right_middle>
	<arrow_right_bottom>
		<src>balloon_arr_rb.gif</src>
		<width>46</width>
		<height>26</height>
	</arrow_right_bottom>
	<arrow_bottom_right>
		<src>balloon_arr_br.gif</src>
		<width>26</width>
		<height>46</height>
	</arrow_bottom_right>
	<arrow_bottom_center>
		<src>balloon_arr_bc.gif</src>
		<width>26</width>
		<height>46</height>
	</arrow_bottom_center>
	<arrow_bottom_left>
		<src>balloon_arr_bl.gif</src>
		<width>26</width>
		<height>46</height>
	</arrow_bottom_left>
	<arrow_left_bottom>
		<src>balloon_arr_lb.gif</src>
		<width>46</width>
		<height>26</height>
	</arrow_left_bottom>
		<arrow_left_middle>
		<src>balloon_arr_lm.gif</src>
		<width>46</width>
		<height>26</height>
	</arrow_left_middle>
	<arrow_left_top>
		<src>balloon_arr_lt.gif</src>
		<width>46</width>
		<height>26</height>
	</arrow_left_top>
	<corner_top_left>
		<src>balloon_tl.gif</src>
		<width>23</width>
		<height>23</height>
	</corner_top_left>
	<corner_top_right>
		<src>balloon_tr.gif</src>
		<width>23</width>
		<height>23</height>
	</corner_top_right>
	<corner_bottom_left>
		<src>balloon_bl.gif</src>
		<width>23</width>
		<height>23</height>
	</corner_bottom_left>
	<corner_bottom_right>
		<src>balloon_br.gif</src>
		<width>23</width>
		<height>23</height>
	</corner_bottom_right>
	<background_top_edge><src>balloon_bg_t.gif</src></background_top_edge>
	<background_right_edge><src>balloon_bg_r.gif</src></background_right_edge>
	<background_left_edge><src>balloon_bg_l.gif</src></background_left_edge>
	<background_bottom_edge><src>balloon_bg_b.gif</src></background_bottom_edge>
	<background_top_edge_small><src>balloon_bg_t_sm.gif</src></background_top_edge_small>
	<background_right_edge_small><src>balloon_bg_r_sm.gif</src></background_right_edge_small>
	<background_left_edge_small><src>balloon_bg_l_sm.gif</src></background_left_edge_small>
	<background_bottom_edge_small><src>balloon_bg_b_sm.gif</src></background_bottom_edge_small>
	<background><src>balloon_bg.gif</src></background>
	<innermargin>0</innermargin>
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
<xsl:variable name="right_width">46</xsl:variable>
<xsl:variable name="left_width">46</xsl:variable>
<xsl:variable name="right_height">26</xsl:variable>
<xsl:variable name="left_height">26</xsl:variable>
<xsl:variable name="top_height">46</xsl:variable>
<xsl:variable name="bottom_height">46</xsl:variable>
<xsl:variable name="right_width_small">23</xsl:variable>
<xsl:variable name="left_width_small">23</xsl:variable>
<xsl:variable name="top_height_small">23</xsl:variable>
<xsl:variable name="bottom_height_small">23</xsl:variable>
<xsl:variable name="cur_folder"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="$cur_profile"/>/</xsl:variable>
<xsl:variable name="blank"><xsl:value-of select="$imagesFolder"/><xsl:value-of select="msxsl:node-set($profile)/blank/src"/></xsl:variable>

<table border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr valign="bottom">
	<td align="right">
			<xsl:choose>
			<xsl:when test="starts-with($cur_arrow,'t')">
				<xsl:attribute name="height"><xsl:value-of select="$top_height"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="height"><xsl:value-of select="$top_height_small"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="starts-with($cur_arrow,'l')">
				<xsl:attribute name="width"><xsl:value-of select="$left_width"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="width"><xsl:value-of select="$left_width_small"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/src"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/width"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_top_left/height"/></xsl:attribute>
		</img>
	</td>

    <td width="100%">
		<xsl:choose>
			<xsl:when test="starts-with($cur_arrow,'t')">
				<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_top_edge/src"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="$top_height"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='tl'">
						<xsl:attribute name="align">left</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$cur_arrow='tr'">
								<xsl:attribute name="align">right</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="align">center</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>				
			<xsl:otherwise>
				<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_top_edge_small/src"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="$top_height_small"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/blank/width"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/blank/height_small"/></xsl:attribute>
		</img>
		<img>
			<xsl:choose>
				<xsl:when test="$cur_arrow='tl'">
					<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_top_left/src"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_left/width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_left/height"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$cur_arrow='tr'">
							<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_top_right/src"/></xsl:attribute>
							<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_right/width"/></xsl:attribute>
							<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_right/height"/></xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="$cur_arrow='tc'">
									<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_top_center/src"/></xsl:attribute>
									<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_center/width"/></xsl:attribute>
									<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_top_center/height"/></xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
									<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/blank/width"/></xsl:attribute>
									<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/blank/height_small"/></xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</img>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/blank/width"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/blank/height_small"/></xsl:attribute>
		</img>
		
	</td>
	<td align="left">
		<xsl:choose>
			<xsl:when test="starts-with($cur_arrow,'t')">
				<xsl:attribute name="height"><xsl:value-of select="$top_height"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="height"><xsl:value-of select="$top_height_small"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="starts-with($cur_arrow,'r')">
				<xsl:attribute name="width"><xsl:value-of select="$right_width"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="width"><xsl:value-of select="$right_width_small"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/corner_top_right/src"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_top_right/width"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_top_right/height"/></xsl:attribute>
		</img>
	</td>	
 </tr>
 <tr> 
    <td>
		<xsl:choose>
			<xsl:when test="starts-with($cur_arrow,'l')">
				<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_left_edge/src"/></xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="$left_width"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='lt'">
						<xsl:attribute name="valign">top</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$cur_arrow='lb'">
								<xsl:attribute name="valign">bottom</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="valign">middle</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>				
			<xsl:otherwise>
				<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_left_edge_small/src"/></xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="$left_width_small"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/blank/width_small"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/blank/height"/></xsl:attribute>
		</img>
		<br/>
		<img>
			<xsl:choose>
				<xsl:when test="$cur_arrow='lt'">
					<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_left_top/src"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_top/width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_top/height"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$cur_arrow='lb'">
							<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_left_bottom/src"/></xsl:attribute>
							<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_bottom/width"/></xsl:attribute>
							<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_bottom/height"/></xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="$cur_arrow='lm'">
									<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_left_middle/src"/></xsl:attribute>
									<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_middle/width"/></xsl:attribute>
									<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_left_middle/height"/></xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
									<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/blank/width_small"/></xsl:attribute>
									<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/blank/height"/></xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</img>
		<br/>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/blank/width_small"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/blank/height"/></xsl:attribute>
		</img>
	</td>
	
	
    <td width="100%">
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
   

	<td>
		<xsl:choose>
			<xsl:when test="starts-with($cur_arrow,'r')">
				<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_right_edge/src"/></xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="$right_width"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='rt'">
						<xsl:attribute name="valign">top</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$cur_arrow='rb'">
								<xsl:attribute name="valign">bottom</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="valign">middle</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>				
			<xsl:otherwise>
				<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_right_edge_small/src"/></xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="$right_width_small"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/blank/width_small"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/blank/height"/></xsl:attribute>
		</img>
		<img>
			<xsl:choose>
				<xsl:when test="$cur_arrow='rt'">
					<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_right_top/src"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_top/width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_top/height"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$cur_arrow='rb'">
							<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_right_bottom/src"/></xsl:attribute>
							<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_bottom/width"/></xsl:attribute>
							<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_bottom/height"/></xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="$cur_arrow='rm'">
									<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_right_middle/src"/></xsl:attribute>
									<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_middle/width"/></xsl:attribute>
									<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_right_middle/height"/></xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
									<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/blank/width_small"/></xsl:attribute>
									<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/blank/height"/></xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>					
				</xsl:otherwise>
			</xsl:choose>
		</img>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/blank/width_small"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/blank/height"/></xsl:attribute>
		</img>
	
	</td>
  </tr> 
  <tr valign="top">
  
	<td align="right">
   		<xsl:choose>
			<xsl:when test="starts-with($cur_arrow,'b')">
				<xsl:attribute name="height"><xsl:value-of select="$bottom_height"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="height"><xsl:value-of select="$bottom_height_small"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="starts-with($cur_arrow,'l')">
				<xsl:attribute name="width"><xsl:value-of select="$left_width"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="width"><xsl:value-of select="$left_width_small"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/src"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/width"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_left/height"/></xsl:attribute>
		</img>
	</td>
	
	
	<td>
		<xsl:choose>
			<xsl:when test="starts-with($cur_arrow,'b')">
				<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_bottom_edge/src"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="$bottom_height"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$cur_arrow='bl'">
						<xsl:attribute name="align">left</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$cur_arrow='br'">
								<xsl:attribute name="align">right</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="align">center</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>				
			<xsl:otherwise>
				<xsl:attribute name="background"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/background_bottom_edge_small/src"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="$bottom_height_small"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/blank/width"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/blank/height_small"/></xsl:attribute>
		</img>
		<img>
			<xsl:choose>
				<xsl:when test="$cur_arrow='bl'">
					<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_left/src"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_left/width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_left/height"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$cur_arrow='br'">
							<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_right/src"/></xsl:attribute>
							<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_right/width"/></xsl:attribute>
							<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_right/height"/></xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="$cur_arrow='bc'">
									<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_center/src"/></xsl:attribute>
									<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_center/width"/></xsl:attribute>
									<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/arrow_bottom_center/height"/></xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
									<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/blank/width"/></xsl:attribute>
									<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/blank/height_small"/></xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</img>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="$blank"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/blank/width"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/blank/height_small"/></xsl:attribute>
		</img>
	</td>	
    <td align="left">
		<xsl:choose>
			<xsl:when test="starts-with($cur_arrow,'b')">
				<xsl:attribute name="height"><xsl:value-of select="$bottom_height"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="height"><xsl:value-of select="$bottom_height_small"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="starts-with($cur_arrow,'r')">
				<xsl:attribute name="width"><xsl:value-of select="$right_width"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="width"><xsl:value-of select="$right_width_small"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="$cur_folder"/><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_right/src"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_right/width"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="msxsl:node-set($profile)/corner_bottom_right/height"/></xsl:attribute>
		</img>
	</td>
  </tr>
</table>

</xsl:template>

</xsl:stylesheet>

