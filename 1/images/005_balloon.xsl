<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
				xmlns:websoft="http://www.websoft.ru"
				xmlns:v="urn:schemas-microsoft-com:vml" 
				version="1.0">
<!--
'*	005_balloon.xsl
'*	Copyright (c) Websoft, 2006.  All rights reserved.
-->

<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>

<xsl:param name="moduleImagesFolder"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="width"></xsl:param>
<xsl:param name="height"></xsl:param>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">

	<xsl:variable name="color.outer">
		<xsl:choose>
			<xsl:when test="balloon_profile='yellow_orange'">#ff9900</xsl:when>
			<xsl:when test="balloon_profile='lyellow_yellow'">#ffeb21</xsl:when>
			<xsl:when test="balloon_profile='lred_red'">#df3c20</xsl:when>
			<xsl:when test="balloon_profile='pink_dpink'">#df2061</xsl:when>
			<xsl:when test="balloon_profile='lmag_mag'">#f49bdc</xsl:when>
			<xsl:when test="balloon_profile='linen_brown'">#b35a46</xsl:when>
			<xsl:when test="balloon_profile='llawn_lawn'">#abd83b</xsl:when>
			<xsl:when test="balloon_profile='lgreen_green'">#458464</xsl:when>
			<xsl:when test="balloon_profile='khaki_olive'">#a59734</xsl:when>
			<xsl:when test="balloon_profile='lcyan_cyan'">#11ead2</xsl:when>
			<xsl:when test="balloon_profile='lcyan_turq'">#5fb2a5</xsl:when>
			<xsl:when test="balloon_profile='lblue_blue'">#6c91c4</xsl:when>
			<xsl:when test="balloon_profile='dblue_blue'">#4e6ed7</xsl:when>
			<xsl:when test="balloon_profile='lviolet_violet'">#8843dd</xsl:when>
			<xsl:when test="balloon_profile='lblue_grey'">#7c7c7c</xsl:when>
			<xsl:when test="balloon_profile='lgrey_grey'">#7c7c7c</xsl:when>
			<xsl:when test="balloon_profile='white_grey'">#7c7c7c</xsl:when>
			<xsl:when test="balloon_profile='custom'"><xsl:value-of select="border_color_custom"/></xsl:when>
			<xsl:otherwise>#999999</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="color.inner">
		<xsl:choose>
			<xsl:when test="balloon_profile='yellow_orange'">#fdf4d0</xsl:when>
			<xsl:when test="balloon_profile='lyellow_yellow'">#f6ffce</xsl:when>
			<xsl:when test="balloon_profile='lred_red'">#fbe9eb</xsl:when>
			<xsl:when test="balloon_profile='pink_dpink'">#f6d6dc</xsl:when>
			<xsl:when test="balloon_profile='lmag_mag'">#fdecf8</xsl:when>
			<xsl:when test="balloon_profile='linen_brown'">#efe4dd</xsl:when>
			<xsl:when test="balloon_profile='llawn_lawn'">#eef7d9</xsl:when>
			<xsl:when test="balloon_profile='lgreen_green'">#cae4e9</xsl:when>
			<xsl:when test="balloon_profile='khaki_olive'">#ecedde</xsl:when>
			<xsl:when test="balloon_profile='lcyan_cyan'">#d3f4f8</xsl:when>
			<xsl:when test="balloon_profile='lcyan_turq'">#ddeeef</xsl:when>
			<xsl:when test="balloon_profile='lblue_blue'">#e7eaf2</xsl:when>
			<xsl:when test="balloon_profile='dblue_blue'">#e7e7f9</xsl:when>
			<xsl:when test="balloon_profile='lviolet_violet'">#f0d0fd</xsl:when>
			<xsl:when test="balloon_profile='lblue_grey'">#d4e0ee</xsl:when>
			<xsl:when test="balloon_profile='lgrey_grey'">#e6e6e6</xsl:when>
			<xsl:when test="balloon_profile='white_grey'">#ffffff</xsl:when>
			<xsl:when test="balloon_profile='custom'"><xsl:value-of select="bg_color_custom"/></xsl:when>
			<xsl:otherwise>#ffffff</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	






	
	<xsl:variable name="arrow.length">65</xsl:variable>
	<xsl:variable name="arrow.height">45</xsl:variable>

	<xsl:variable name="padding.text">
		<xsl:choose>
			<xsl:when test="string(number(balloon_margin))='NaN'">6</xsl:when>
			<xsl:otherwise><xsl:value-of select="balloon_margin"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="shape.width">
		<xsl:choose>
			<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb' or arrow='rt' or arrow='rm' or arrow='rb'"><xsl:value-of select="number($width) - number($arrow.length) - 1"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="number($width)-1"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="shape.left">
		<xsl:choose>
			<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="$arrow.length"/></xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="shape.top">
		<xsl:choose>
			<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="$arrow.height"/></xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="shape.radius">10</xsl:variable>
	<xsl:variable name="shape.strokeweight">2</xsl:variable>
	<xsl:variable name="shape.height">120</xsl:variable>
	<xsl:variable name="shape.xunit" select="1000 div number($shape.width)"/>
	<xsl:variable name="shape.yunit" select="1000 div number($shape.height)"/>
	<xsl:variable name="shape.path">M<xsl:value-of select="round(number($shape.xunit))"/>,<xsl:value-of select="round(number($shape.yunit)*number($shape.radius))"/> QY<xsl:value-of select="round(number($shape.xunit)*number($shape.radius))"/>,<xsl:value-of select="round(number($shape.yunit))"/> L<xsl:value-of select="1000 - round(number($shape.xunit)*number($shape.radius))"/>,<xsl:value-of select="round(number($shape.yunit))"/> QX<xsl:value-of select="1000 - round(number($shape.xunit))"/>,<xsl:value-of select="round(number($shape.yunit)*number($shape.radius))"/> L<xsl:value-of select="1000 - round(number($shape.xunit))"/>,<xsl:value-of select="1000 - round(number($shape.yunit)*number($shape.radius))"/> QY<xsl:value-of select="1000 - round(number($shape.xunit)*number($shape.radius))"/>,<xsl:value-of select="1000 - round(number($shape.yunit))"/> L<xsl:value-of select="round(number($shape.xunit)*number($shape.radius))"/>,<xsl:value-of select="1000 - round(number($shape.yunit))"/> QX<xsl:value-of select="round(number($shape.xunit))"/>,<xsl:value-of select="1000 - round(number($shape.yunit)*number($shape.radius))"/> XE</xsl:variable>
	<xsl:variable name="balloon.w3c.width" select="number($shape.width) - 4"/>
	<xsl:variable name="shadow.color">
		<xsl:choose>
			<xsl:when test="shadow_strength='extralight'">#CCCCCC</xsl:when>
			<xsl:when test="shadow_strength='light'">#999999</xsl:when>
			<xsl:when test="shadow_strength='dark'">#333333</xsl:when>
			<xsl:when test="shadow_strength='extradark'">#000000</xsl:when>
			<xsl:otherwise>#666666</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="shadow.string.w3c">
		<xsl:choose>
			<xsl:when test="shadow_strength='extralight'">2px 2px 6px #CCCCCC</xsl:when>
			<xsl:when test="shadow_strength='light'">2px 2px 6px #999999</xsl:when>
			<xsl:when test="shadow_strength='dark'">2px 2px 6px #333333</xsl:when>
			<xsl:when test="shadow_strength='extradark'">2px 2px 6px #000000</xsl:when>
			<xsl:otherwise>2px 2px 6px #666666</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
		
	<xsl:variable name="small.width">
		<xsl:choose>
			<xsl:when test="arrow='tc' or arrow='bc'">11</xsl:when>
			<xsl:when test="arrow='lm' or arrow='rm'">13</xsl:when>
			<xsl:otherwise>14</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="small.height">
		<xsl:choose>
			<xsl:when test="arrow='tc' or arrow='bc'">7</xsl:when>
			<xsl:when test="arrow='lm' or arrow='rm'">9</xsl:when>
			<xsl:otherwise>10</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="small.left">
		<xsl:choose>
			<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb' or arrow='tl' or arrow='bl'">0</xsl:when>
			<xsl:when test="arrow='rt' or arrow='rm' or arrow='rb' or arrow='tr' or arrow='br'"><xsl:value-of select="number($width)-number($small.width)-1"/></xsl:when>
			<xsl:when test="arrow='tc' or arrow='bc'"><xsl:value-of select="round(0.5*(number($width)-number($small.width)))"/></xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="small.top">0</xsl:variable>
	<xsl:variable name="small.w3c.width" select="number($small.width) - 4"/>
	<xsl:variable name="small.w3c.height" select="number($small.height) - 4"/>
	<xsl:variable name="small.rh" select="round(0.5*number($small.w3c.width))+1"/>
	<xsl:variable name="small.rv" select="round(0.5*number($small.w3c.height))+1"/>

	<xsl:variable name="medium.offsetx.tl">17</xsl:variable>
	<xsl:variable name="medium.offsetx.lt">14</xsl:variable>
	<xsl:variable name="medium.offsetx.lm">17</xsl:variable>
	<xsl:variable name="medium.offsety.tl">8</xsl:variable>
	<xsl:variable name="medium.offsety.lt">10</xsl:variable>
	<xsl:variable name="medium.offsety.tc">9</xsl:variable>
	<xsl:variable name="medium.width">
		<xsl:choose>
			<xsl:when test="arrow='tc' or arrow='bc'">18</xsl:when>
			<xsl:when test="arrow='lm' or arrow='rm'">15</xsl:when>
			<xsl:otherwise>17</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="medium.height">
		<xsl:choose>
			<xsl:when test="arrow='tc' or arrow='bc'">13</xsl:when>
			<xsl:when test="arrow='lm' or arrow='rm'">14</xsl:when>
			<xsl:otherwise>13</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="medium.left">
		<xsl:choose>
			<xsl:when test="arrow='lt' or arrow='lb'"><xsl:value-of select="$medium.offsetx.lt"/></xsl:when>
			<xsl:when test="arrow='lm'"><xsl:value-of select="$medium.offsetx.lm"/></xsl:when>
			<xsl:when test="arrow='tl' or arrow='bl'"><xsl:value-of select="$medium.offsetx.tl"/></xsl:when>
			<xsl:when test="arrow='tc' or arrow='bc'"><xsl:value-of select="round(0.5*(number($width)-number($medium.width)))"/></xsl:when>
			<xsl:when test="arrow='tr' or arrow='br'"><xsl:value-of select="number($width) - number($medium.offsetx.tl) - number($medium.width)"/></xsl:when>
			<xsl:when test="arrow='rt' or arrow='rb'"><xsl:value-of select="number($width) - number($medium.offsetx.lt) - number($medium.width)"/></xsl:when>
			<xsl:when test="arrow='rm'"><xsl:value-of select="number($width) - number($medium.offsetx.lm) - number($medium.width) - 1"/></xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="medium.top">
		<xsl:choose>
			<xsl:when test="arrow='lt' or arrow='rt'"><xsl:value-of select="$medium.offsety.lt"/></xsl:when>
			<xsl:when test="arrow='tl' or arrow='tr'"><xsl:value-of select="$medium.offsety.tl"/></xsl:when>
			<xsl:when test="arrow='tc'"><xsl:value-of select="$medium.offsety.tc"/></xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="medium.w3c.width" select="number($medium.width) - 4"/>
	<xsl:variable name="medium.w3c.height" select="number($medium.height) - 4"/>
	<xsl:variable name="medium.rh" select="round(0.5*number($medium.w3c.width))+1"/>
	<xsl:variable name="medium.rv" select="round(0.5*number($medium.w3c.height))+1"/>
	<xsl:variable name="large.offsetx.tl">30</xsl:variable>
	<xsl:variable name="large.offsetx.lt">35</xsl:variable>
	<xsl:variable name="large.offsetx.lm">37</xsl:variable>
	<xsl:variable name="large.offsety.tl">22</xsl:variable>
	<xsl:variable name="large.offsety.lt">15</xsl:variable>
	<xsl:variable name="large.offsety.tc">24</xsl:variable>
	<xsl:variable name="large.width">
		<xsl:choose>
			<xsl:when test="arrow='tc' or arrow='bc'">28</xsl:when>
			<xsl:when test="arrow='lm' or arrow='rm'">25</xsl:when>
			<xsl:otherwise>27</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="large.height">
		<xsl:choose>
			<xsl:when test="arrow='tc' or arrow='bc'">17</xsl:when>
			<xsl:when test="arrow='lm' or arrow='rm'">21</xsl:when>
			<xsl:otherwise>18</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="large.left">
		<xsl:choose>
			<xsl:when test="arrow='lt' or arrow='lb'"><xsl:value-of select="$large.offsetx.lt"/></xsl:when>
			<xsl:when test="arrow='lm'"><xsl:value-of select="$large.offsetx.lm"/></xsl:when>
			<xsl:when test="arrow='tl' or arrow='bl'"><xsl:value-of select="$large.offsetx.tl"/></xsl:when>
			<xsl:when test="arrow='tc' or arrow='bc'"><xsl:value-of select="round(0.5*(number($width)-number($large.width)))"/></xsl:when>
			<xsl:when test="arrow='tr' or arrow='br'"><xsl:value-of select="number($width) - number($large.offsetx.tl) - number($large.width)"/></xsl:when>
			<xsl:when test="arrow='rt' or arrow='rb'"><xsl:value-of select="number($width) - number($large.offsetx.lt) - number($large.width)"/></xsl:when>
			<xsl:when test="arrow='rm'"><xsl:value-of select="number($width) - number($large.offsetx.lm) - number($large.width) - 1"/></xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="large.top">
		<xsl:choose>
			<xsl:when test="arrow='lt' or arrow='rt'"><xsl:value-of select="$large.offsety.lt"/></xsl:when>
			<xsl:when test="arrow='tl' or arrow='tr'"><xsl:value-of select="$large.offsety.tl"/></xsl:when>
			<xsl:when test="arrow='tc'"><xsl:value-of select="$large.offsety.tc"/></xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="large.w3c.width" select="number($large.width) - 4"/>
	<xsl:variable name="large.w3c.height" select="number($large.height) - 4"/>
	<xsl:variable name="large.rh" select="round(0.5*number($large.w3c.width))+1"/>
	<xsl:variable name="large.rv" select="round(0.5*number($large.w3c.height))+1"/>
	<div>
		<xsl:attribute name="style">position: absolute; left: 0px; top: 0px; width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_vml_div</xsl:attribute>
			<xsl:attribute name="style">position: absolute; left: 0px; top: 0px; width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
			<xsl:attribute name="xunit"><xsl:value-of select="$shape.xunit"/></xsl:attribute>
			<xsl:attribute name="smallh"><xsl:value-of select="$small.height"/></xsl:attribute>
			<xsl:attribute name="mediumh"><xsl:value-of select="$medium.height"/></xsl:attribute>
			<xsl:attribute name="largeh"><xsl:value-of select="$large.height"/></xsl:attribute>
			<xsl:attribute name="mediumoffset">
				<xsl:choose>
					<xsl:when test="arrow='lb' or arrow='rb'"><xsl:value-of select="$medium.offsety.lt"/></xsl:when>
					<xsl:when test="arrow='bl' or arrow='br'"><xsl:value-of select="$medium.offsety.tl"/></xsl:when>
					<xsl:when test="arrow='bc'"><xsl:value-of select="$medium.offsety.tc"/></xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="largeoffset">
				<xsl:choose>
					<xsl:when test="arrow='lb' or arrow='rb'"><xsl:value-of select="$large.offsety.lt"/></xsl:when>
					<xsl:when test="arrow='bl' or arrow='br'"><xsl:value-of select="$large.offsety.tl"/></xsl:when>
					<xsl:when test="arrow='bc'"><xsl:value-of select="$large.offsety.tc"/></xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<v:shape>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_shape</xsl:attribute>	
				<xsl:attribute name="style">position: absolute; top: <xsl:value-of select="$shape.top"/>px; left: <xsl:value-of select="$shape.left"/>px; width: <xsl:value-of select="$shape.width"/>px; height: <xsl:value-of select="$shape.height"/>px;</xsl:attribute>
				<xsl:attribute name="coordsize">1000,1000</xsl:attribute>
				<xsl:attribute name="filled">t</xsl:attribute>
				<xsl:attribute name="fillcolor"><xsl:value-of select="$color.inner"/></xsl:attribute>
				<xsl:attribute name="stroked">t</xsl:attribute>
				<xsl:attribute name="strokecolor"><xsl:value-of select="$color.outer"/></xsl:attribute>
				<xsl:attribute name="strokeweight">2px</xsl:attribute>
				<xsl:attribute name="path"><xsl:value-of select="$shape.path"/></xsl:attribute>
				<v:textbox inset="10px 10px 10px 10px">
					<div>
						<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_txt</xsl:attribute>	
						<xsl:attribute name="style">margin: <xsl:value-of select="$padding.text"/>px;</xsl:attribute>
						<xsl:value-of select="balloon_text" disable-output-escaping="yes"/>
					</div>
				</v:textbox>
				<xsl:if test="shadow='yes'">
					<v:shadow on="true" obscured="true" opacity="0.8">
						<xsl:attribute name="color"><xsl:value-of select="$shadow.color"/></xsl:attribute>
						<xsl:attribute name="offset">4px,4px</xsl:attribute>
					</v:shadow>
				</xsl:if>
			</v:shape>
			
			<xsl:if test="arrow!='no'">
				<v:shape>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_shape_small</xsl:attribute>	
					<xsl:attribute name="style">position: absolute; left: <xsl:value-of select="$small.left"/>px; top: <xsl:value-of select="$small.top"/>px; width: <xsl:value-of select="$small.width"/>px; height: <xsl:value-of select="$small.height"/>px;</xsl:attribute>
					<xsl:attribute name="coordsize">1000,1000</xsl:attribute>
					<xsl:attribute name="filled">t</xsl:attribute>
					<xsl:attribute name="fillcolor"><xsl:value-of select="$color.inner"/></xsl:attribute>
					<xsl:attribute name="stroked">t</xsl:attribute>
					<xsl:attribute name="strokecolor"><xsl:value-of select="$color.outer"/></xsl:attribute>
					<xsl:attribute name="strokeweight">2px</xsl:attribute>
					<xsl:attribute name="path">M0,500 QY500,0 QX1000,500 QY500,1000 QX0,500 E</xsl:attribute>
					<xsl:if test="shadow='yes'">
						<v:shadow on="true" obscured="true" opacity="0.8">
							<xsl:attribute name="color"><xsl:value-of select="$shadow.color"/></xsl:attribute>
							<xsl:attribute name="offset">3px,3px</xsl:attribute>
						</v:shadow>
					</xsl:if>
				</v:shape>
				<v:shape>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_shape_medium</xsl:attribute>	
					<xsl:attribute name="style">position: absolute; left: <xsl:value-of select="$medium.left"/>px; top: <xsl:value-of select="$medium.top"/>px; width: <xsl:value-of select="$medium.width"/>px; height: <xsl:value-of select="$medium.height"/>px;</xsl:attribute>
					<xsl:attribute name="coordsize">1000,1000</xsl:attribute>
					<xsl:attribute name="filled">t</xsl:attribute>
					<xsl:attribute name="fillcolor"><xsl:value-of select="$color.inner"/></xsl:attribute>
					<xsl:attribute name="stroked">t</xsl:attribute>
					<xsl:attribute name="strokecolor"><xsl:value-of select="$color.outer"/></xsl:attribute>
					<xsl:attribute name="strokeweight">2px</xsl:attribute>
					<xsl:attribute name="path">M0,500 QY500,0 QX1000,500 QY500,1000 QX0,500 E</xsl:attribute>
					<xsl:if test="shadow='yes'">
						<v:shadow on="true" obscured="true" opacity="0.8">
							<xsl:attribute name="color"><xsl:value-of select="$shadow.color"/></xsl:attribute>
							<xsl:attribute name="offset">3px,3px</xsl:attribute>
						</v:shadow>
					</xsl:if>
				</v:shape>
				<v:shape>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_shape_large</xsl:attribute>	
					<xsl:attribute name="style">position: absolute; left: <xsl:value-of select="$large.left"/>px; top: <xsl:value-of select="$large.top"/>px; width: <xsl:value-of select="$large.width"/>px; height: <xsl:value-of select="$large.height"/>px;</xsl:attribute>
					<xsl:attribute name="coordsize">1000,1000</xsl:attribute>
					<xsl:attribute name="filled">t</xsl:attribute>
					<xsl:attribute name="fillcolor"><xsl:value-of select="$color.inner"/></xsl:attribute>
					<xsl:attribute name="stroked">t</xsl:attribute>
					<xsl:attribute name="strokecolor"><xsl:value-of select="$color.outer"/></xsl:attribute>
					<xsl:attribute name="strokeweight">2px</xsl:attribute>
					<xsl:attribute name="path">M0,500 QY500,0 QX1000,500 QY500,1000 QX0,500 E</xsl:attribute>
					<xsl:if test="shadow='yes'">
						<v:shadow on="true" obscured="true" opacity="0.8">
							<xsl:attribute name="color"><xsl:value-of select="$shadow.color"/></xsl:attribute>
							<xsl:attribute name="offset">3px,3px</xsl:attribute>
						</v:shadow>
					</xsl:if>
				</v:shape>
			</xsl:if>
		</div>

		<div>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_w3c_div</xsl:attribute>
			<xsl:attribute name="style">position: absolute; left: 0px; top: 0px; width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
			<xsl:attribute name="smallh"><xsl:value-of select="$small.height"/></xsl:attribute>
			<xsl:attribute name="mediumh"><xsl:value-of select="$medium.height"/></xsl:attribute>
			<xsl:attribute name="largeh"><xsl:value-of select="$large.height"/></xsl:attribute>
			<xsl:attribute name="mediumoffset">
				<xsl:choose>
					<xsl:when test="arrow='lb' or arrow='rb'"><xsl:value-of select="$medium.offsety.lt"/></xsl:when>
					<xsl:when test="arrow='bl' or arrow='br'"><xsl:value-of select="$medium.offsety.tl"/></xsl:when>
					<xsl:when test="arrow='bc'"><xsl:value-of select="$medium.offsety.tc"/></xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="largeoffset">
				<xsl:choose>
					<xsl:when test="arrow='lb' or arrow='rb'"><xsl:value-of select="$large.offsety.lt"/></xsl:when>
					<xsl:when test="arrow='bl' or arrow='br'"><xsl:value-of select="$large.offsety.tl"/></xsl:when>
					<xsl:when test="arrow='bc'"><xsl:value-of select="$large.offsety.tc"/></xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_w3c_shape</xsl:attribute>
				<xsl:attribute name="style"><xsl:if test="shadow='yes'">-moz-box-shadow: <xsl:value-of select="$shadow.string.w3c"/>; -webkit-box-shadow: <xsl:value-of select="$shadow.string.w3c"/>; box-shadow: <xsl:value-of select="$shadow.string.w3c"/>;</xsl:if>position: absolute; top: <xsl:value-of select="$shape.top"/>px; left: <xsl:value-of select="$shape.left"/>px; width: <xsl:value-of select="$balloon.w3c.width"/>px; -moz-border-radius: 10px; -webkit-border-radius: 10px; -khtml-border-radius: 10px; border-radius: 10px; background-color: <xsl:value-of select="$color.inner"/>; border: solid 2px <xsl:value-of select="$color.outer"/>;</xsl:attribute>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_txt_w3c</xsl:attribute>
					<xsl:attribute name="style">margin: <xsl:value-of select="number($padding.text) + 8"/>px;</xsl:attribute>
					<xsl:value-of select="balloon_text" disable-output-escaping="yes"/>
				</div>
			</div>

			<xsl:if test="arrow!='no'">
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_bubble_small</xsl:attribute>	
					<xsl:attribute name="style">position: absolute; overflow: hidden; left: <xsl:value-of select="$small.left"/>px; top: <xsl:value-of select="$small.top"/>px; width: <xsl:value-of select="$small.w3c.width"/>px; height: <xsl:value-of select="$small.w3c.height"/>px; -moz-border-radius: <xsl:value-of select="$small.rh"/>px/<xsl:value-of select="$small.rv"/>px; -webkit-border-radius: <xsl:value-of select="$small.rh"/>px/<xsl:value-of select="$small.rv"/>px; -khtml-border-radius: <xsl:value-of select="$small.rh"/>px/<xsl:value-of select="$small.rv"/>px; border-radius: <xsl:value-of select="$small.rh"/>px/<xsl:value-of select="$small.rv"/>px; background-color: <xsl:value-of select="$color.inner"/>; border: solid 2px <xsl:value-of select="$color.outer"/>; <xsl:if test="shadow='yes'">-moz-box-shadow: <xsl:value-of select="$shadow.string.w3c"/>; -webkit-box-shadow: <xsl:value-of select="$shadow.string.w3c"/>; box-shadow: <xsl:value-of select="$shadow.string.w3c"/>;</xsl:if></xsl:attribute>
					<br/>
				</div>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_bubble_medium</xsl:attribute>	
					<xsl:attribute name="style">position: absolute; overflow: hidden; left: <xsl:value-of select="$medium.left"/>px; top: <xsl:value-of select="$medium.top"/>px; width: <xsl:value-of select="$medium.w3c.width"/>px; height: <xsl:value-of select="$medium.w3c.height"/>px; -moz-border-radius: <xsl:value-of select="$medium.rh"/>px/<xsl:value-of select="$medium.rv"/>px; -webkit-border-radius: <xsl:value-of select="$medium.rh"/>px/<xsl:value-of select="$medium.rv"/>px; -khtml-border-radius: <xsl:value-of select="$medium.rh"/>px/<xsl:value-of select="$medium.rv"/>px; border-radius: <xsl:value-of select="$medium.rh"/>px/<xsl:value-of select="$medium.rv"/>px; background-color: <xsl:value-of select="$color.inner"/>; border: solid 2px <xsl:value-of select="$color.outer"/>; <xsl:if test="shadow='yes'">-moz-box-shadow: <xsl:value-of select="$shadow.string.w3c"/>; -webkit-box-shadow: <xsl:value-of select="$shadow.string.w3c"/>; box-shadow: <xsl:value-of select="$shadow.string.w3c"/>;</xsl:if></xsl:attribute>
					<br/>
				</div>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_bubble_large</xsl:attribute>	
					<xsl:attribute name="style">position: absolute; overflow: hidden; left: <xsl:value-of select="$large.left"/>px; top: <xsl:value-of select="$large.top"/>px; width: <xsl:value-of select="$large.w3c.width"/>px; height: <xsl:value-of select="$large.w3c.height"/>px; -moz-border-radius: <xsl:value-of select="$large.rh"/>px/<xsl:value-of select="$large.rv"/>px; -webkit-border-radius: <xsl:value-of select="$large.rh"/>px/<xsl:value-of select="$large.rv"/>px; -khtml-border-radius: <xsl:value-of select="$large.rh"/>px/<xsl:value-of select="$large.rv"/>px; border-radius: <xsl:value-of select="$large.rh"/>px/<xsl:value-of select="$large.rv"/>px; background-color: <xsl:value-of select="$color.inner"/>; border: solid 2px <xsl:value-of select="$color.outer"/>; <xsl:if test="shadow='yes'">-moz-box-shadow: <xsl:value-of select="$shadow.string.w3c"/>; -webkit-box-shadow: <xsl:value-of select="$shadow.string.w3c"/>; box-shadow: <xsl:value-of select="$shadow.string.w3c"/>;</xsl:if></xsl:attribute>
					<br/>
				</div>
			</xsl:if>
		</div>
	</div>
	<v:group/>

</xsl:template>

</xsl:stylesheet>