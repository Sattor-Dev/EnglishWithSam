<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				xmlns:v="urn:schemas-microsoft-com:vml" 
				version="1.0">
<!--
'*	002_textbox#.xsl
'*	Copyright (c) Websoft Ltd., Russia.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="moduleImagesFolder"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="width"></xsl:param>
<xsl:param name="height"></xsl:param>
<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">

	<xsl:variable name="color.fill">
		<xsl:choose>
			<xsl:when test="textbox_profile='blue'">#7c7cfc</xsl:when>
			<xsl:when test="textbox_profile='brown'">#a3795e</xsl:when>
			<xsl:when test="textbox_profile='green'">#6caf66</xsl:when>
			<xsl:when test="textbox_profile='grey'">#8a8a8a</xsl:when>
			<xsl:when test="textbox_profile='orange'">#e27d3c</xsl:when>
			<xsl:when test="textbox_profile='pink'">#ce72ae</xsl:when>
			<xsl:when test="textbox_profile='red'">#ee6b64</xsl:when>
			<xsl:when test="textbox_profile='violet'">#9c6cef</xsl:when>
			<xsl:when test="textbox_profile='yellow'">#d6c96e</xsl:when>
			<xsl:when test="textbox_profile='custom'"><xsl:value-of select="fill_color_custom"/></xsl:when>
			<xsl:otherwise>#eeeeee</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="color.h">
		<xsl:call-template name="hue">
			<xsl:with-param name="hexcolor" select="$color.fill"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="color.s">
		<xsl:call-template name="saturation">
			<xsl:with-param name="hexcolor" select="$color.fill"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="color.b">
		<xsl:call-template name="brightness">
			<xsl:with-param name="hexcolor" select="$color.fill"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="s.light">
		<xsl:choose>
			<xsl:when test="(number($color.s) - 10) &gt; 5"><xsl:value-of select="number($color.s) - 10"/></xsl:when>
			<xsl:otherwise>5</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="b.light">
		<xsl:choose>
			<xsl:when test="(number($color.b) + 10) &lt; 100"><xsl:value-of select="number($color.b) + 10"/></xsl:when>
			<xsl:otherwise>100</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="s.dark">
		<xsl:choose>
			<xsl:when test="(number($color.s) + 10) &lt; 100"><xsl:value-of select="number($color.s) + 10"/></xsl:when>
			<xsl:otherwise>100</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="b.dark">
		<xsl:choose>
			<xsl:when test="(number($color.b) - 10) &gt; 5"><xsl:value-of select="number($color.b) - 10"/></xsl:when>
			<xsl:otherwise>5</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="s.lighter">
		<xsl:choose>
			<xsl:when test="(number($color.s) - 20) &gt; 5"><xsl:value-of select="number($color.s) - 20"/></xsl:when>
			<xsl:otherwise>5</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="b.lighter">
		<xsl:choose>
			<xsl:when test="(number($color.b) + 20) &lt; 100"><xsl:value-of select="number($color.b) + 20"/></xsl:when>
			<xsl:otherwise>100</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="s.darker">
		<xsl:choose>
			<xsl:when test="(number($color.s) + 20) &lt; 100"><xsl:value-of select="number($color.s) + 20"/></xsl:when>
			<xsl:otherwise>100</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="b.darker">
		<xsl:choose>
			<xsl:when test="(number($color.b) - 20) &gt; 5"><xsl:value-of select="number($color.b) - 20"/></xsl:when>
			<xsl:otherwise>5</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="color.light">
		<xsl:call-template name="HSBtoHex">
			<xsl:with-param name="H" select="$color.h"/>
			<xsl:with-param name="S" select="$s.light"/>
			<xsl:with-param name="B" select="$b.light"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="color.dark">
		<xsl:call-template name="HSBtoHex">
			<xsl:with-param name="H" select="$color.h"/>
			<xsl:with-param name="S" select="$s.dark"/>
			<xsl:with-param name="B" select="$b.dark"/>
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:variable name="color.lighter">
		<xsl:call-template name="HSBtoHex">
			<xsl:with-param name="H" select="$color.h"/>
			<xsl:with-param name="S" select="$s.lighter"/>
			<xsl:with-param name="B" select="$b.lighter"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="color.darker">
		<xsl:call-template name="HSBtoHex">
			<xsl:with-param name="H" select="$color.h"/>
			<xsl:with-param name="S" select="$s.darker"/>
			<xsl:with-param name="B" select="$b.darker"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="color.bg">
		<xsl:choose>
			<xsl:when test="bg_color_custom=''">#FFFFFF</xsl:when>
			<xsl:otherwise><xsl:value-of select="bg_color_custom"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="padding.text">
		<xsl:choose>
			<xsl:when test="string(number(textbox_margin))='NaN'">0</xsl:when>
			<xsl:otherwise><xsl:value-of select="textbox_margin"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="shadow.color">
		<xsl:choose>
			<xsl:when test="shadow_strength='extralight'">#CCCCCC</xsl:when>
			<xsl:when test="shadow_strength='light'">#999999</xsl:when>
			<xsl:when test="shadow_strength='dark'">#333333</xsl:when>
			<xsl:when test="shadow_strength='extradark'">#000000</xsl:when>
			<xsl:otherwise>#666666</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="shape.0.top">1</xsl:variable>
	<xsl:variable name="shape.0.left">1</xsl:variable>
	<xsl:variable name="shape.0.width" select="number($width)-2"/>
	<xsl:variable name="shape.0.height" select="number($height)-2"/>
	<xsl:variable name="shape.0.radius">13</xsl:variable>

	<xsl:variable name="shape.1.top">2</xsl:variable>
	<xsl:variable name="shape.1.left">3</xsl:variable>
	<xsl:variable name="shape.1.width" select="number($width)-4"/>
	<xsl:variable name="shape.1.height" select="number($height)-4"/>
	<xsl:variable name="shape.1.radius">12</xsl:variable>

	<xsl:variable name="shape.2.top">3</xsl:variable>
	<xsl:variable name="shape.2.left">3</xsl:variable>
	<xsl:variable name="shape.2.width" select="number($width)-6"/>
	<xsl:variable name="shape.2.height" select="number($height)-6"/>
	<xsl:variable name="shape.2.radius">11</xsl:variable>

	<xsl:variable name="shape.3.top">4</xsl:variable>
	<xsl:variable name="shape.3.left">4</xsl:variable>
	<xsl:variable name="shape.3.width" select="number($width)-8"/>
	<xsl:variable name="shape.3.height" select="number($height)-8"/>
	<xsl:variable name="shape.3.radius">10</xsl:variable>

	<xsl:variable name="shape.4.top">5</xsl:variable>
	<xsl:variable name="shape.4.left">5</xsl:variable>
	<xsl:variable name="shape.4.width" select="number($width)-10"/>
	<xsl:variable name="shape.4.height" select="number($height)-10"/>
	<xsl:variable name="shape.4.radius">9</xsl:variable>

	<xsl:variable name="text.top" select="number($padding.text) + 13"/>
	<xsl:variable name="text.left" select="number($padding.text) + 13"/>
	<xsl:variable name="text.width" select="number($width)- 2*number($padding.text) - 26"/>
	<xsl:variable name="text.height" select="number($height)- 2*number($padding.text) - 26"/>

	<xsl:variable name="shape.0.xunit" select="1000 div number($shape.0.width)"/>
	<xsl:variable name="shape.1.xunit" select="1000 div number($shape.1.width)"/>
	<xsl:variable name="shape.2.xunit" select="1000 div number($shape.2.width)"/>
	<xsl:variable name="shape.3.xunit" select="1000 div number($shape.3.width)"/>
	<xsl:variable name="shape.4.xunit" select="1000 div number($shape.4.width)"/>

	<xsl:variable name="shape.0.yunit" select="1000 div number($shape.0.height)"/>
	<xsl:variable name="shape.1.yunit" select="1000 div number($shape.1.height)"/>
	<xsl:variable name="shape.2.yunit" select="1000 div number($shape.2.height)"/>
	<xsl:variable name="shape.3.yunit" select="1000 div number($shape.3.height)"/>
	<xsl:variable name="shape.4.yunit" select="1000 div number($shape.4.height)"/>
	
	<xsl:variable name="shape.0.x0" select="0"/>
	<xsl:variable name="shape.0.x1" select="round(number($shape.0.xunit) * number($shape.0.radius))"/>
	<xsl:variable name="shape.0.x2" select="1000 - round(number($shape.0.xunit) * number($shape.0.radius))"/>
	<xsl:variable name="shape.0.x3" select="1000"/>
	<xsl:variable name="shape.0.y0" select="0"/>
	<xsl:variable name="shape.0.y1" select="round(number($shape.0.yunit) * number($shape.0.radius))"/>
	<xsl:variable name="shape.0.y2" select="1000 - round(number($shape.0.yunit) * number($shape.0.radius))"/>
	<xsl:variable name="shape.0.y3" select="1000"/>

	<xsl:variable name="shape.1.x0" select="0"/>
	<xsl:variable name="shape.1.x1" select="round(number($shape.1.xunit) * number($shape.1.radius))"/>
	<xsl:variable name="shape.1.x2" select="1000 - round(number($shape.1.xunit) * number($shape.1.radius))"/>
	<xsl:variable name="shape.1.x3" select="1000"/>
	<xsl:variable name="shape.1.y0" select="0"/>
	<xsl:variable name="shape.1.y1" select="round(number($shape.1.yunit) * number($shape.1.radius))"/>
	<xsl:variable name="shape.1.y2" select="1000 - round(number($shape.1.yunit) * number($shape.1.radius))"/>
	<xsl:variable name="shape.1.y3" select="1000"/>

	<xsl:variable name="shape.2.x0" select="0"/>
	<xsl:variable name="shape.2.x1" select="round(number($shape.2.xunit) * number($shape.2.radius))"/>
	<xsl:variable name="shape.2.x2" select="1000 - round(number($shape.2.xunit) * number($shape.2.radius))"/>
	<xsl:variable name="shape.2.x3" select="1000"/>
	<xsl:variable name="shape.2.y0" select="0"/>
	<xsl:variable name="shape.2.y1" select="round(number($shape.2.yunit) * number($shape.2.radius))"/>
	<xsl:variable name="shape.2.y2" select="1000 - round(number($shape.2.yunit) * number($shape.2.radius))"/>
	<xsl:variable name="shape.2.y3" select="1000"/>

	<xsl:variable name="shape.3.x0" select="0"/>
	<xsl:variable name="shape.3.x1" select="round(number($shape.3.xunit) * number($shape.3.radius))"/>
	<xsl:variable name="shape.3.x2" select="1000 - round(number($shape.3.xunit) * number($shape.3.radius))"/>
	<xsl:variable name="shape.3.x3" select="1000"/>
	<xsl:variable name="shape.3.y0" select="0"/>
	<xsl:variable name="shape.3.y1" select="round(number($shape.3.yunit) * number($shape.3.radius))"/>
	<xsl:variable name="shape.3.y2" select="1000 - round(number($shape.3.yunit) * number($shape.3.radius))"/>
	<xsl:variable name="shape.3.y3" select="1000"/>

	<xsl:variable name="shape.4.x0" select="0"/>
	<xsl:variable name="shape.4.x1" select="round(number($shape.4.xunit) * number($shape.4.radius))"/>
	<xsl:variable name="shape.4.x2" select="1000 - round(number($shape.4.xunit) * number($shape.4.radius))"/>
	<xsl:variable name="shape.4.x3" select="1000"/>
	<xsl:variable name="shape.4.y0" select="0"/>
	<xsl:variable name="shape.4.y1" select="round(number($shape.4.yunit) * number($shape.4.radius))"/>
	<xsl:variable name="shape.4.y2" select="1000 - round(number($shape.4.yunit) * number($shape.4.radius))"/>
	<xsl:variable name="shape.4.y3" select="1000"/>

	<xsl:variable name="shape.0.path">M<xsl:value-of select="$shape.0.x0"/>,<xsl:value-of select="$shape.0.y1"/> QY<xsl:value-of select="$shape.0.x1"/>,<xsl:value-of select="$shape.0.y0"/> L<xsl:value-of select="$shape.0.x2"/>,<xsl:value-of select="$shape.0.y0"/> QX<xsl:value-of select="$shape.0.x3"/>,<xsl:value-of select="$shape.0.y1"/> L<xsl:value-of select="$shape.0.x3"/>,<xsl:value-of select="$shape.0.y2"/> QY<xsl:value-of select="$shape.0.x2"/>,<xsl:value-of select="$shape.0.y3"/> L<xsl:value-of select="$shape.0.x1"/>,<xsl:value-of select="$shape.0.y3"/> QX<xsl:value-of select="$shape.0.x0"/>,<xsl:value-of select="$shape.0.y2"/> XE</xsl:variable>
	<xsl:variable name="shape.1.path">M<xsl:value-of select="$shape.1.x0"/>,<xsl:value-of select="$shape.1.y1"/> QY<xsl:value-of select="$shape.1.x1"/>,<xsl:value-of select="$shape.1.y0"/> L<xsl:value-of select="$shape.1.x2"/>,<xsl:value-of select="$shape.1.y0"/> QX<xsl:value-of select="$shape.1.x3"/>,<xsl:value-of select="$shape.1.y1"/> L<xsl:value-of select="$shape.1.x3"/>,<xsl:value-of select="$shape.1.y2"/> QY<xsl:value-of select="$shape.1.x2"/>,<xsl:value-of select="$shape.1.y3"/> L<xsl:value-of select="$shape.1.x1"/>,<xsl:value-of select="$shape.1.y3"/> QX<xsl:value-of select="$shape.1.x0"/>,<xsl:value-of select="$shape.1.y2"/> XE</xsl:variable>
	<xsl:variable name="shape.2.path">M<xsl:value-of select="$shape.2.x0"/>,<xsl:value-of select="$shape.2.y1"/> QY<xsl:value-of select="$shape.2.x1"/>,<xsl:value-of select="$shape.2.y0"/> L<xsl:value-of select="$shape.2.x2"/>,<xsl:value-of select="$shape.2.y0"/> QX<xsl:value-of select="$shape.2.x3"/>,<xsl:value-of select="$shape.2.y1"/> L<xsl:value-of select="$shape.2.x3"/>,<xsl:value-of select="$shape.2.y2"/> QY<xsl:value-of select="$shape.2.x2"/>,<xsl:value-of select="$shape.2.y3"/> L<xsl:value-of select="$shape.2.x1"/>,<xsl:value-of select="$shape.2.y3"/> QX<xsl:value-of select="$shape.2.x0"/>,<xsl:value-of select="$shape.2.y2"/> XE</xsl:variable>
	<xsl:variable name="shape.3.path">M<xsl:value-of select="$shape.3.x0"/>,<xsl:value-of select="$shape.3.y1"/> QY<xsl:value-of select="$shape.3.x1"/>,<xsl:value-of select="$shape.3.y0"/> L<xsl:value-of select="$shape.3.x2"/>,<xsl:value-of select="$shape.3.y0"/> QX<xsl:value-of select="$shape.3.x3"/>,<xsl:value-of select="$shape.3.y1"/> L<xsl:value-of select="$shape.3.x3"/>,<xsl:value-of select="$shape.3.y2"/> QY<xsl:value-of select="$shape.3.x2"/>,<xsl:value-of select="$shape.3.y3"/> L<xsl:value-of select="$shape.3.x1"/>,<xsl:value-of select="$shape.3.y3"/> QX<xsl:value-of select="$shape.3.x0"/>,<xsl:value-of select="$shape.3.y2"/> XE</xsl:variable>
	<xsl:variable name="shape.4.path">M<xsl:value-of select="$shape.4.x0"/>,<xsl:value-of select="$shape.4.y1"/> QY<xsl:value-of select="$shape.4.x1"/>,<xsl:value-of select="$shape.4.y0"/> L<xsl:value-of select="$shape.4.x2"/>,<xsl:value-of select="$shape.4.y0"/> QX<xsl:value-of select="$shape.4.x3"/>,<xsl:value-of select="$shape.4.y1"/> L<xsl:value-of select="$shape.4.x3"/>,<xsl:value-of select="$shape.4.y2"/> QY<xsl:value-of select="$shape.4.x2"/>,<xsl:value-of select="$shape.4.y3"/> L<xsl:value-of select="$shape.4.x1"/>,<xsl:value-of select="$shape.4.y3"/> QX<xsl:value-of select="$shape.4.x0"/>,<xsl:value-of select="$shape.4.y2"/> XE</xsl:variable>

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_vml_div</xsl:attribute>	
		<xsl:attribute name="style">position: absolute; top: 0px; left: 0px; width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
		<v:shape>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_vml_shape_0</xsl:attribute>	
			<xsl:attribute name="style">position: absolute; top: <xsl:value-of select="$shape.0.top"/>px; left: <xsl:value-of select="$shape.0.left"/>px; width: <xsl:value-of select="$shape.0.width"/>px; height: <xsl:value-of select="$shape.0.height"/>px;</xsl:attribute>
			<xsl:attribute name="coordsize">1000,1000</xsl:attribute>
			<xsl:attribute name="filled">t</xsl:attribute>
			<xsl:attribute name="fillcolor"><xsl:value-of select="$color.lighter"/></xsl:attribute>
			<xsl:attribute name="stroked">f</xsl:attribute>
			<xsl:attribute name="strokecolor"><xsl:value-of select="$color.light"/></xsl:attribute>
			<xsl:attribute name="strokeweight">0px</xsl:attribute>
			<xsl:attribute name="path"><xsl:value-of select="$shape.0.path"/></xsl:attribute>
			<v:fill>
				<xsl:attribute name="type">gradient</xsl:attribute>
				<xsl:attribute name="color"><xsl:value-of select="$color.lighter"/></xsl:attribute>
				<xsl:attribute name="color2"><xsl:value-of select="$color.darker"/></xsl:attribute>
				<xsl:attribute name="angle">210</xsl:attribute>
			</v:fill>
			<xsl:if test="shadow='yes'">
				<v:shadow on="true" obscured="true" opacity="0.8">
					<xsl:attribute name="color"><xsl:value-of select="$shadow.color"/></xsl:attribute>
					<xsl:attribute name="offset">4px,4px</xsl:attribute>
				</v:shadow>
			</xsl:if>
		</v:shape>
		<v:shape>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_vml_shape_1</xsl:attribute>	
			<xsl:attribute name="style">position: absolute; top: <xsl:value-of select="$shape.1.top"/>px; left: <xsl:value-of select="$shape.1.left"/>px; width: <xsl:value-of select="$shape.1.width"/>px; height: <xsl:value-of select="$shape.1.height"/>px;</xsl:attribute>
			<xsl:attribute name="coordsize">1000,1000</xsl:attribute>
			<xsl:attribute name="filled">t</xsl:attribute>
			<xsl:attribute name="fillcolor"><xsl:value-of select="$color.fill"/></xsl:attribute>
			<xsl:attribute name="stroked">f</xsl:attribute>
			<xsl:attribute name="strokecolor"><xsl:value-of select="$color.fill"/></xsl:attribute>
			<xsl:attribute name="strokeweight">0px</xsl:attribute>
			<xsl:attribute name="path"><xsl:value-of select="$shape.1.path"/></xsl:attribute>
			<v:fill>
				<xsl:attribute name="type">gradient</xsl:attribute>
				<xsl:attribute name="color"><xsl:value-of select="$color.fill"/></xsl:attribute>
				<xsl:attribute name="color2"><xsl:value-of select="$color.dark"/></xsl:attribute>
				<xsl:attribute name="angle">210</xsl:attribute>
			</v:fill>
		</v:shape>
		<v:shape>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_vml_shape_2</xsl:attribute>	
			<xsl:attribute name="style">position: absolute; top: <xsl:value-of select="$shape.2.top"/>px; left: <xsl:value-of select="$shape.2.left"/>px; width: <xsl:value-of select="$shape.2.width"/>px; height: <xsl:value-of select="$shape.2.height"/>px;</xsl:attribute>
			<xsl:attribute name="coordsize">1000,1000</xsl:attribute>
			<xsl:attribute name="filled">t</xsl:attribute>
			<xsl:attribute name="fillcolor"><xsl:value-of select="$color.fill"/></xsl:attribute>
			<xsl:attribute name="stroked">f</xsl:attribute>
			<xsl:attribute name="strokecolor"><xsl:value-of select="$color.fill"/></xsl:attribute>
			<xsl:attribute name="strokeweight">0px</xsl:attribute>
			<xsl:attribute name="path"><xsl:value-of select="$shape.2.path"/></xsl:attribute>
			<v:fill>
				<xsl:attribute name="type">gradient</xsl:attribute>
				<xsl:attribute name="color"><xsl:value-of select="$color.fill"/></xsl:attribute>
				<xsl:attribute name="color2"><xsl:value-of select="$color.fill"/></xsl:attribute>
				<xsl:attribute name="angle">210</xsl:attribute>
			</v:fill>
		</v:shape>
		<v:shape>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_vml_shape_3</xsl:attribute>	
			<xsl:attribute name="style">position: absolute; top: <xsl:value-of select="$shape.3.top"/>px; left: <xsl:value-of select="$shape.3.left"/>px; width: <xsl:value-of select="$shape.3.width"/>px; height: <xsl:value-of select="$shape.3.height"/>px;</xsl:attribute>
			<xsl:attribute name="coordsize">1000,1000</xsl:attribute>
			<xsl:attribute name="filled">t</xsl:attribute>
			<xsl:attribute name="fillcolor"><xsl:value-of select="$color.dark"/></xsl:attribute>
			<xsl:attribute name="stroked">f</xsl:attribute>
			<xsl:attribute name="strokecolor"><xsl:value-of select="$color.dark"/></xsl:attribute>
			<xsl:attribute name="strokeweight">0px</xsl:attribute>
			<xsl:attribute name="path"><xsl:value-of select="$shape.3.path"/></xsl:attribute>
			<v:fill>
				<xsl:attribute name="type">gradient</xsl:attribute>
				<xsl:attribute name="color"><xsl:value-of select="$color.darker"/></xsl:attribute>
				<xsl:attribute name="color2"><xsl:value-of select="$color.lighter"/></xsl:attribute>
				<xsl:attribute name="angle">210</xsl:attribute>
			</v:fill>
		</v:shape>
		
		<v:shape>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_vml_shape_4</xsl:attribute>	
			<xsl:attribute name="style">position: absolute; top: <xsl:value-of select="$shape.4.top"/>px; left: <xsl:value-of select="$shape.4.left"/>px; width: <xsl:value-of select="$shape.4.width"/>px; height: <xsl:value-of select="$shape.4.height"/>px;</xsl:attribute>
			<xsl:attribute name="coordsize">1000,1000</xsl:attribute>
			<xsl:attribute name="filled">t</xsl:attribute>
			<xsl:attribute name="fillcolor"><xsl:value-of select="$color.bg"/></xsl:attribute>
			<xsl:attribute name="stroked">f</xsl:attribute>
			<xsl:attribute name="strokecolor"><xsl:value-of select="$color.bg"/></xsl:attribute>
			<xsl:attribute name="strokeweight">0px</xsl:attribute>
			<xsl:attribute name="path"><xsl:value-of select="$shape.4.path"/></xsl:attribute>
		</v:shape>
		
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_txt</xsl:attribute>	
			<xsl:attribute name="style">position: absolute; top: <xsl:value-of select="$text.top"/>px; left: <xsl:value-of select="$text.left"/>px; width: <xsl:value-of select="$text.width"/>px; height: <xsl:value-of select="$text.height"/>px; <xsl:choose><xsl:when test="overflow='fit'">overflow: visible;</xsl:when><xsl:when test="overflow='scroll'">overflow: y:;</xsl:when><xsl:when test="overflow='scroll-y'">overflow-y: scroll; overflow-x: hidden;</xsl:when><xsl:when test="overflow='scroll-x'">overflow-x: scroll; overflow-y: hidden;</xsl:when><xsl:when test="overflow='auto'">overflow-x: hidden; overflow-y: auto;</xsl:when><xsl:when test="overflow='hidden'">overflow: hidden;</xsl:when></xsl:choose></xsl:attribute>
			<xsl:value-of select="textbox_text" disable-output-escaping="yes"/>
		</div>
		<v:group/>
		
	</div>

</xsl:template>

<!--
	COLOR CONVERSION START
	Templates:
		lighten (color.base: 7-character hex color value, starts with #, ratio - 0-1 - darken, 1+ - lighten) = 7-character hex color value, starts with #
		getcolor (color.base: 7-character hex color value, starts with #, color.base.type - string [color1|color2], color.target.type - string [color1|color2|color3|color4\stroke|font]) = 7-character hex color value, starts with #
		hex2todec (hex2: 2-character hex value) = integer decimal value
		hex1todec (hex: 1-character hex value) = integer decimal value
		dectohex2 (dec2: 0-255 decimal value) = 2-character hex value
		dectohex1 (dec: 0-15 decimal value) = 1-character hex value
		hue (hexcolor: 7-character hex color value, starts with #) = 0-360 degrees integer decimal hue value
		saturation (hexcolor: 7-character hex color value, starts with #) = 0-100 percents integer decimal saturation value
		brightness (hexcolor: 7-character hex color value, starts with #) = 0-100 percents integer decimal brightness value
		inverted (hexcolor: 7-character hex color value, starts with #) = 7-character hex color value, starts with #
		max (C1,C2,C3: decimal values) = maximal from these 3 values
		min (C1,C2,C3: decimal values) = minimal from these 3 values
		RGBtoHex (R,G,B: decimal 0-255 color values) = 7-character hex color value, starts with #
		HSBtoHex (H: 0-360 degrees integer decimal hue value,S,B: decimal 0-100 percent saturation and brightness values) = 7-character hex color value, starts with #
-->
	<xsl:template match="*" name="lighten">
		
		<xsl:param name="color.base"/>
		<xsl:param name="ratio"/>
		<xsl:variable name="base.H">
			<xsl:call-template name="hue">
				<xsl:with-param name="hexcolor" select="$color.base"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="base.S">
			<xsl:call-template name="saturation">
				<xsl:with-param name="hexcolor" select="$color.base"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="base.B">
			<xsl:call-template name="brightness">
				<xsl:with-param name="hexcolor" select="$color.base"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="target.B">
			<xsl:choose>
				<xsl:when test="(number($base.B)*number($ratio)) &gt; 100">100</xsl:when>
				<xsl:otherwise><xsl:value-of select="round(number($base.B)*number($ratio))"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>	
		<xsl:call-template name="HSBtoHex">
			<xsl:with-param name="H" select="$base.H"/>
			<xsl:with-param name="S" select="$base.S"/>
			<xsl:with-param name="B" select="$target.B"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="*" name="getcolor">
		
		<xsl:param name="color.base"/>
		<xsl:param name="color.base.type"/>
		<xsl:param name="color.target.type"/>
		
		<xsl:variable name="base.H">
			<xsl:call-template name="hue">
				<xsl:with-param name="hexcolor" select="$color.base"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="base.S">
			<xsl:call-template name="saturation">
				<xsl:with-param name="hexcolor" select="$color.base"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="base.B">
			<xsl:call-template name="brightness">
				<xsl:with-param name="hexcolor" select="$color.base"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="target.H" select="$base.H"/>
		<xsl:variable name="target.S">
			<xsl:choose>
				<xsl:when test="$color.base.type='color1'">
					<xsl:choose>
						<xsl:when test="$color.target.type='color2'"><xsl:value-of select="round(0.35*number($base.S))"/></xsl:when>
						<xsl:when test="$color.target.type='color3'"><xsl:value-of select="round(0.67 * number($base.S))"/></xsl:when>
						<xsl:when test="$color.target.type='color4'"><xsl:value-of select="round(0.56 * number($base.S))"/></xsl:when>
						<xsl:when test="$color.target.type='stroke' or $color.target.type='font'">
							<xsl:choose>
								<xsl:when test="round(1.2*number($base.S)) &gt; 100">100</xsl:when>
								<xsl:otherwise><xsl:value-of select="round(1.2*number($base.S))"/></xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise><xsl:value-of select="$base.S"/></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$color.base.type='color2'">
					<xsl:choose>
						<xsl:when test="$color.target.type='color1'">
							<xsl:choose>
								<xsl:when test="(2.8*number($base.S)) &gt; 100">100</xsl:when>
								<xsl:otherwise><xsl:value-of select="round(2.8*number($base.S))"/></xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="$color.target.type='color3'">
							<xsl:choose>
								<xsl:when test="(1.56*number($base.S)) &gt; 100">100</xsl:when>
								<xsl:otherwise><xsl:value-of select="round(1.56 * number($base.S))"/></xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="$color.target.type='color4'">
							<xsl:choose>
								<xsl:when test="(1.88*number($base.S)) &gt; 100">100</xsl:when>
								<xsl:otherwise><xsl:value-of select="round(1.88 * number($base.S))"/></xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="$color.target.type='stroke'">
							<xsl:choose>
								<xsl:when test="round(3.38*number($base.S)) &gt; 100">100</xsl:when>
								<xsl:otherwise><xsl:value-of select="round(3.38*number($base.S))"/></xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="$color.target.type='font'">
							<xsl:choose>
								<xsl:when test="round(3.38*number($base.S)) &gt; 100">100</xsl:when>
								<xsl:otherwise><xsl:value-of select="round(3.38*number($base.S))"/></xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise><xsl:value-of select="$base.S"/></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="$base.S"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="target.B">
			<xsl:choose>
				<xsl:when test="$color.base.type='color1'">
					<xsl:choose>
						<xsl:when test="$color.target.type='color2'">
							<xsl:choose>
								<xsl:when test="number($base.B) &lt; 70">
									<xsl:choose>
										<xsl:when test="(number($base.B)*1.4) &gt; 100">100</xsl:when>
										<xsl:otherwise><xsl:value-of select="round(number($base.B)*1.4)"/></xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="(number($base.B)*1.2) &gt; 100">100</xsl:when>
										<xsl:otherwise><xsl:value-of select="round(number($base.B)*1.2)"/></xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="$color.target.type='color3'">
							<xsl:choose>
								<xsl:when test="(number($base.B)*1.09) &gt; 100">100</xsl:when>
								<xsl:otherwise><xsl:value-of select="round(number($base.B)*1.08)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="$color.target.type='color4'">
							<xsl:choose>
								<xsl:when test="(number($base.B)*1.13) &gt; 100">100</xsl:when>
								<xsl:otherwise><xsl:value-of select="round(number($base.B)*1.13)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="$color.target.type='stroke'"><xsl:value-of select="round(0.75*number($base.B))"/></xsl:when>
						<xsl:when test="$color.target.type='font'"><xsl:value-of select="round(0.5*number($base.B))"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="$base.B"/></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$color.base.type='color2'">
					<xsl:choose>
						<xsl:when test="$color.target.type='color1'"><xsl:value-of select="round(0.83*number($base.B))"/></xsl:when>
						<xsl:when test="$color.target.type='color3'"><xsl:value-of select="round(0.91*number($base.B))"/></xsl:when>
						<xsl:when test="$color.target.type='color4'"><xsl:value-of select="round(0.94*number($base.B))"/></xsl:when>
						<xsl:when test="$color.target.type='stroke'"><xsl:value-of select="round(0.62*number($base.B))"/></xsl:when>
						<xsl:when test="$color.target.type='font'"><xsl:value-of select="round(0.53*number($base.B))"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="$base.B"/></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="$base.B"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="HSBtoHex">
			<xsl:with-param name="H" select="$target.H"/>
			<xsl:with-param name="S" select="$target.S"/>
			<xsl:with-param name="B" select="$target.B"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="*" name="hex2todec">
		<xsl:param name="hex2"/>
		<xsl:variable name="d1">
			<xsl:call-template name="hex1todec">
				<xsl:with-param name="hex" select="substring(string($hex2), 1, 1)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="d2">
			<xsl:call-template name="hex1todec">
				<xsl:with-param name="hex" select="substring(string($hex2), 2, 1)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="number($d1)*16 + number($d2)"/>
	</xsl:template> 
	<xsl:template match="*" name="hex1todec">
		<xsl:param name="hex"/>
		<xsl:choose>
			<xsl:when test="$hex='A' or $hex='a'">10</xsl:when>
			<xsl:when test="$hex='B' or $hex='b'">11</xsl:when>
			<xsl:when test="$hex='C' or $hex='c'">12</xsl:when>
			<xsl:when test="$hex='D' or $hex='d'">13</xsl:when>
			<xsl:when test="$hex='E' or $hex='e'">14</xsl:when>
			<xsl:when test="$hex='F' or $hex='f'">15</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="string(number($hex))='NaN'">0</xsl:when>
					<xsl:otherwise><xsl:value-of select="$hex"/></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template> 
	<xsl:template match="*" name="dectohex2">
		<xsl:param name="dec2"/>
		<xsl:variable name="d1" select="floor(number($dec2) div 16)"/>
		<xsl:variable name="d2" select="number($dec2) - (number($d1)*16)"/>
		<xsl:variable name="h1">
			<xsl:call-template name="dectohex1">
				<xsl:with-param name="dec" select="$d1"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="h2">
			<xsl:call-template name="dectohex1">
				<xsl:with-param name="dec" select="$d2"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(string($h1), string($h2))"/>
	</xsl:template> 
	<xsl:template match="*" name="dectohex1">
		<xsl:param name="dec"/>
		<xsl:choose>
			<xsl:when test="number($dec)=10">A</xsl:when>
			<xsl:when test="number($dec)=11">B</xsl:when>
			<xsl:when test="number($dec)=12">C</xsl:when>
			<xsl:when test="number($dec)=13">D</xsl:when>
			<xsl:when test="number($dec)=14">E</xsl:when>
			<xsl:when test="number($dec)=15">F</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="string(number($dec))='NaN'">0</xsl:when>
					<xsl:otherwise><xsl:value-of select="$dec"/></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template> 
	<xsl:template match="*" name="hue">
		<xsl:param name="hexcolor"/>
		<xsl:choose>
			<xsl:when test="string-length($hexcolor)=7">
				<xsl:choose>
					<xsl:when test="substring($hexcolor, 1, 1)='#'">
						<xsl:variable name="rhex" select="substring($hexcolor, 2, 2)"/>
						<xsl:variable name="ghex" select="substring($hexcolor, 4, 2)"/>
						<xsl:variable name="bhex" select="substring($hexcolor, 6, 2)"/>
						<xsl:variable name="rdec">
							<xsl:call-template name="hex2todec">
								<xsl:with-param name="hex2" select="$rhex"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="gdec">
							<xsl:call-template name="hex2todec">
								<xsl:with-param name="hex2" select="$ghex"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="bdec">
							<xsl:call-template name="hex2todec">
								<xsl:with-param name="hex2" select="$bhex"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="Rn" select="number($rdec) div 255"/>
						<xsl:variable name="Gn" select="number($gdec) div 255"/>
						<xsl:variable name="Bn" select="number($bdec) div 255"/>
						<xsl:variable name="Cmax">
							<xsl:call-template name="max">
								<xsl:with-param name="C1" select="$Rn"/>
								<xsl:with-param name="C2" select="$Gn"/>
								<xsl:with-param name="C3" select="$Bn"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="Cmin">
							<xsl:call-template name="min">
								<xsl:with-param name="C1" select="$Rn"/>
								<xsl:with-param name="C2" select="$Gn"/>
								<xsl:with-param name="C3" select="$Bn"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="Cdif" select="number($Cmax) - number($Cmin)"/>
						<xsl:choose>
							<xsl:when test="$Cdif='0'">0</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="(number($Cmax)=number($Rn)) and (number($Gn) &gt;= number($Bn))">
										<xsl:value-of select="round(60 * (number($Gn) - number($Bn)) div number($Cdif))"/>
									</xsl:when>
									<xsl:when test="(number($Cmax)=number($Rn)) and (number($Gn) &lt; number($Bn))">
										<xsl:value-of select="round(60 * (number($Gn) - number($Bn)) div number($Cdif)) + 360"/>
									</xsl:when>
									<xsl:when test="number($Cmax)=number($Gn)">
										<xsl:value-of select="round(60 * (number($Bn) - number($Rn)) div number($Cdif)) + 120"/>
									</xsl:when>
									<xsl:when test="number($Cmax)=number($Bn)">
										<xsl:value-of select="round(60 * (number($Rn) - number($Gn)) div number($Cdif)) + 240"/>
									</xsl:when>
									<xsl:otherwise>0</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*" name="saturation">
		<xsl:param name="hexcolor"/>
		<xsl:choose>
			<xsl:when test="string-length($hexcolor)=7">
				<xsl:choose>
					<xsl:when test="substring($hexcolor, 1, 1)='#'">
						<xsl:variable name="rhex" select="substring($hexcolor, 2, 2)"/>
						<xsl:variable name="ghex" select="substring($hexcolor, 4, 2)"/>
						<xsl:variable name="bhex" select="substring($hexcolor, 6, 2)"/>
						<xsl:variable name="rdec">
							<xsl:call-template name="hex2todec">
								<xsl:with-param name="hex2" select="$rhex"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="gdec">
							<xsl:call-template name="hex2todec">
								<xsl:with-param name="hex2" select="$ghex"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="bdec">
							<xsl:call-template name="hex2todec">
								<xsl:with-param name="hex2" select="$bhex"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="Rn" select="number($rdec) div 255"/>
						<xsl:variable name="Gn" select="number($gdec) div 255"/>
						<xsl:variable name="Bn" select="number($bdec) div 255"/>
						<xsl:variable name="Cmax">
							<xsl:call-template name="max">
								<xsl:with-param name="C1" select="$Rn"/>
								<xsl:with-param name="C2" select="$Gn"/>
								<xsl:with-param name="C3" select="$Bn"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="Cmin">
							<xsl:call-template name="min">
								<xsl:with-param name="C1" select="$Rn"/>
								<xsl:with-param name="C2" select="$Gn"/>
								<xsl:with-param name="C3" select="$Bn"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="(number($Cmax) - number($Cmin))=0">0</xsl:when>
							<xsl:otherwise><xsl:value-of select="round(100*(1 - (number($Cmin) div number($Cmax))))"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*" name="brightness">
		<xsl:param name="hexcolor"/>
		<xsl:choose>
			<xsl:when test="string-length($hexcolor)=7">
				<xsl:choose>
					<xsl:when test="substring($hexcolor, 1, 1)='#'">
						<xsl:variable name="rhex" select="substring($hexcolor, 2, 2)"/>
						<xsl:variable name="ghex" select="substring($hexcolor, 4, 2)"/>
						<xsl:variable name="bhex" select="substring($hexcolor, 6, 2)"/>
						<xsl:variable name="rdec">
							<xsl:call-template name="hex2todec">
								<xsl:with-param name="hex2" select="$rhex"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="gdec">
							<xsl:call-template name="hex2todec">
								<xsl:with-param name="hex2" select="$ghex"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="bdec">
							<xsl:call-template name="hex2todec">
								<xsl:with-param name="hex2" select="$bhex"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="Rn" select="number($rdec) div 255"/>
						<xsl:variable name="Gn" select="number($gdec) div 255"/>
						<xsl:variable name="Bn" select="number($bdec) div 255"/>
						<xsl:variable name="Cmax">
							<xsl:call-template name="max">
								<xsl:with-param name="C1" select="$Rn"/>
								<xsl:with-param name="C2" select="$Gn"/>
								<xsl:with-param name="C3" select="$Bn"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="Cmin">
							<xsl:call-template name="min">
								<xsl:with-param name="C1" select="$Rn"/>
								<xsl:with-param name="C2" select="$Gn"/>
								<xsl:with-param name="C3" select="$Bn"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:value-of select="round(100*number($Cmax))"/>
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*" name="inverted">
		<xsl:param name="hexcolor"/>
		<xsl:choose>
			<xsl:when test="string-length($hexcolor)=7">
				<xsl:choose>
					<xsl:when test="substring($hexcolor, 1, 1)='#'">
						<xsl:variable name="rhex" select="substring($hexcolor, 2, 2)"/>
						<xsl:variable name="ghex" select="substring($hexcolor, 4, 2)"/>
						<xsl:variable name="bhex" select="substring($hexcolor, 6, 2)"/>
						<xsl:variable name="rdec">
							<xsl:call-template name="hex2todec">
								<xsl:with-param name="hex2" select="$rhex"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="gdec">
							<xsl:call-template name="hex2todec">
								<xsl:with-param name="hex2" select="$ghex"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="bdec">
							<xsl:call-template name="hex2todec">
								<xsl:with-param name="hex2" select="$bhex"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:call-template name="RGBtoHex">
							<xsl:with-param name="R" select="255 - number($rdec)"/>
							<xsl:with-param name="G" select="255 - number($gdec)"/>
							<xsl:with-param name="B" select="255 - number($bdec)"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>#000000</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>#000000</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*" name="max">
		<xsl:param name="C1"/>
		<xsl:param name="C2"/>
		<xsl:param name="C3"/>
		<xsl:choose>
			<xsl:when test="number($C1) &gt;= number($C2)">
				<xsl:choose>
					<xsl:when test="number($C1) &gt;= number($C3)"><xsl:value-of select="$C1"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="$C3"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="number($C2) &gt;= number($C3)"><xsl:value-of select="$C2"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$C3"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*" name="min">
		<xsl:param name="C1"/>
		<xsl:param name="C2"/>
		<xsl:param name="C3"/>
		<xsl:choose>
			<xsl:when test="(number($C1) &lt;= number($C2)) and (number($C1) &lt;= number($C3))"><xsl:value-of select="$C1"/></xsl:when>
			<xsl:when test="(number($C2) &lt;= number($C1)) and (number($C2) &lt;= number($C3))"><xsl:value-of select="$C2"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$C3"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*" name="RGBtoHex">
		<xsl:param name="R"/>
		<xsl:param name="G"/>
		<xsl:param name="B"/>
		<xsl:variable name="Rhex">
			<xsl:call-template name="dectohex2">
				<xsl:with-param name="dec2" select="$R"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="Ghex">
			<xsl:call-template name="dectohex2">
				<xsl:with-param name="dec2" select="$G"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="Bhex">
			<xsl:call-template name="dectohex2">
				<xsl:with-param name="dec2" select="$B"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat('#',$Rhex,$Ghex,$Bhex)"/>
	</xsl:template>
	<xsl:template match="*" name="HSBtoHex">
		<xsl:param name="H"/>
		<xsl:param name="S"/>
		<xsl:param name="B"/>
		<xsl:variable name="hsector" select="floor(number($H) div 60)"/>
		<xsl:variable name="hdiff" select="(number($H) div 60) - number($hsector)"/>
		<xsl:variable name="sdec" select="number($S) div 100"/>
		<xsl:variable name="bdec" select="number($B) div 100"/>
		<xsl:variable name="c1" select="number($bdec) * (1 - number($sdec))"/>
		<xsl:variable name="c2" select="number($bdec) * (1 - (number($sdec) * number($hdiff)))"/>
		<xsl:variable name="c3" select="number($bdec) * (1 - ((1 - number($hdiff)) * number($sdec)))"/>
		<xsl:choose>
			<xsl:when test="number($hsector)=0">
				<xsl:call-template name="RGBtoHex">
					<xsl:with-param name="R" select="round(number($bdec) * 255)"/>
					<xsl:with-param name="G" select="round(number($c3) * 255)"/>
					<xsl:with-param name="B" select="round(number($c1) * 255)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="number($hsector)=1">
				<xsl:call-template name="RGBtoHex">
					<xsl:with-param name="R" select="round(number($c2) * 255)"/>
					<xsl:with-param name="G" select="round(number($bdec) * 255)"/>
					<xsl:with-param name="B" select="round(number($c1) * 255)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="number($hsector)=2">
				<xsl:call-template name="RGBtoHex">
					<xsl:with-param name="R" select="round(number($c1) * 255)"/>
					<xsl:with-param name="G" select="round(number($bdec) * 255)"/>
					<xsl:with-param name="B" select="round(number($c3) * 255)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="number($hsector)=3">
				<xsl:call-template name="RGBtoHex">
					<xsl:with-param name="R" select="round(number($c1) * 255)"/>
					<xsl:with-param name="G" select="round(number($c2) * 255)"/>
					<xsl:with-param name="B" select="round(number($bdec) * 255)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="number($hsector)=4">
				<xsl:call-template name="RGBtoHex">
					<xsl:with-param name="R" select="round(number($c3) * 255)"/>
					<xsl:with-param name="G" select="round(number($c1) * 255)"/>
					<xsl:with-param name="B" select="round(number($bdec) * 255)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="number($hsector)=5">
				<xsl:call-template name="RGBtoHex">
					<xsl:with-param name="R" select="round(number($bdec) * 255)"/>
					<xsl:with-param name="G" select="round(number($c1) * 255)"/>
					<xsl:with-param name="B" select="round(number($c2) * 255)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="RGBtoHex">
					<xsl:with-param name="R" select="round(number($bdec) * 255)"/>
					<xsl:with-param name="G" select="round(number($c3) * 255)"/>
					<xsl:with-param name="B" select="round(number($c1) * 255)"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
<!--COLOR CONVERSION END-->

</xsl:stylesheet>
