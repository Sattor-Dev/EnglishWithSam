<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	media_003_video.xsl
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

	<xsl:variable name="object.template">media_003_video</xsl:variable>
	<xsl:variable name="movie.path">
		<xsl:choose>
			<xsl:when  test="vURL='yes'"><xsl:value-of select="video_url"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="video_uri"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="player.type">
		<xsl:choose>
			<xsl:when test="player!='auto'"><xsl:value-of select="player"/></xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="contains($movie.path,'.mov')">qtp</xsl:when>
					<xsl:when test="contains($movie.path,'.3gp')">qtp</xsl:when>
					<xsl:when test="contains($movie.path,'.rm')">rp</xsl:when>
					<xsl:when test="contains($movie.path,'.ram')">rp</xsl:when>
					<xsl:when test="contains($movie.path,'.rt')">rp</xsl:when>
					<xsl:when test="contains($movie.path,'.rp')">rp</xsl:when>
					<xsl:when test="contains($movie.path,'.ra')">rp</xsl:when>
					<xsl:when test="contains($movie.path,'.rt')">rp</xsl:when>
					<xsl:when test="contains($movie.path,'.rv')">rp</xsl:when>
					<xsl:when test="contains($movie.path,'.rmvb')">rp</xsl:when>
					<xsl:otherwise>wmp</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_container</xsl:attribute>
		<xsl:attribute name="style">position: absolute; top: 0px; left: 0px width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
		<xsl:choose>
			<xsl:when test="$player.type='rp'">
				<object>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_rmp_ie</xsl:attribute>
					<xsl:attribute name="classid">clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA</xsl:attribute>
					<xsl:attribute name="codebase">http://www.real.com/</xsl:attribute>
					<xsl:attribute name="width">100%</xsl:attribute>
					<xsl:attribute name="height">100%</xsl:attribute>
					<param name="src">
						<xsl:attribute name="value"><xsl:value-of select="$movie.path"/></xsl:attribute>
					</param>
					<param name="controls">
						<xsl:attribute name="value">
							<xsl:if test="video_controls='full'">All</xsl:if>
							<xsl:if test="video_controls='mini'">PlayButton</xsl:if>
							<xsl:if test="video_controls='no'">ImageWindow</xsl:if>
						</xsl:attribute>
					</param>
					<embed pluginspage="http://www.real.com/" bgcolor="">
						<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_rmp_w3c</xsl:attribute>
						<xsl:attribute name="name"><xsl:value-of select="$objectID"/>_rmp_w3c</xsl:attribute>
						<xsl:attribute name="src"><xsl:value-of select="$movie.path"/></xsl:attribute>
						<xsl:attribute name="width">100%</xsl:attribute>
						<xsl:attribute name="height">100%</xsl:attribute>
						<xsl:attribute name="controls">
							<xsl:if test="video_controls='full'">All</xsl:if>
							<xsl:if test="video_controls='mini'">PlayButton</xsl:if>
							<xsl:if test="video_controls='no'">ImageWindow</xsl:if>
						</xsl:attribute>
					</embed>
				</object>
			</xsl:when>
			<xsl:when test="$player.type='qtp'">
				<object>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_qtp_ie</xsl:attribute>
					<xsl:attribute name="style">position: absolute; top: 0px; left: 0px width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; visibility: hidden;</xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
					<xsl:attribute name="type">video/quicktime</xsl:attribute>
					<xsl:attribute name="classid">clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B</xsl:attribute>
					<xsl:attribute name="codebase">http://www.apple.com/qtactivex/qtplugin.cab</xsl:attribute>
					<param name="scale" value="tofit"/>
					<param name="postdomevents" value="true" />
					<param name="src">
						<xsl:attribute name="value"><xsl:value-of select="$movie.path"/></xsl:attribute>
					</param>
					<param name="autoplay">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_autostart='yes'">true</xsl:when>
								<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="controller">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_controls!='no'">true</xsl:when>
								<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
				</object>
				<object>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_qtp_w3c</xsl:attribute>
					<xsl:attribute name="style">position: absolute; top: 0px; left: 0px width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; visibility: hidden;</xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
					<xsl:attribute name="type">video/quicktime</xsl:attribute>
					<xsl:attribute name="data"><xsl:value-of select="$movie.path"/></xsl:attribute>
					<param name="scale" value="tofit"/>
					<param name="postdomevents" value="true" />
					<param name="autoplay">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_autostart='yes'">true</xsl:when>
								<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="controller">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_controls!='no'">true</xsl:when>
								<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
				</object>
			</xsl:when>
			<xsl:otherwise>
				<object>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_wmp_ie</xsl:attribute>
					<xsl:attribute name="style">position: absolute; top: 0px; left: 0px width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; visibility: hidden;</xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
					<xsl:attribute name="type">application/x-ms-wmp</xsl:attribute>
					<xsl:attribute name="classid">clsid:6BF52A52-394A-11D3-B153-00C04F79FAA6</xsl:attribute>
					<param name="uiMode">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_invisible='no'">
									<xsl:choose>
										<xsl:when test="video_controls!='no'"><xsl:value-of select="video_controls"/></xsl:when>
										<xsl:otherwise>none</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>invisible</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="ShowControls">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_controls='no'">0</xsl:when>
								<xsl:otherwise>1</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="ShowStatusBar" value="0"/>
					<param name="AutoStart">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_autostart='no'">0</xsl:when>
								<xsl:otherwise>1</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="URL">
						<xsl:attribute name="value"><xsl:value-of select="$movie.path"/></xsl:attribute>
					</param>
					<param name="windowlessVideo">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_windowless='yes'">1</xsl:when>
								<xsl:otherwise>0</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="AutoSize" value="1" />
					<param name="AutoRewind" value="0" />
					<param name="SendPlayStateChangeEvents" value="1"/>
					<param name="AllowChangeDisplaySize" value="0" />
				</object>
				<object>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_wmp_w3c</xsl:attribute>
					<xsl:attribute name="style">position: absolute; top: 0px; left: 0px width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; visibility: hidden;</xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
					<xsl:attribute name="type">application/x-ms-wmp</xsl:attribute>
					<xsl:attribute name="data"><xsl:value-of select="$movie.path"/></xsl:attribute>
					<param name="uiMode">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_invisible='no'">
									<xsl:choose>
										<xsl:when test="video_controls!='no'"><xsl:value-of select="video_controls"/></xsl:when>
										<xsl:otherwise>none</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>invisible</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="ShowControls">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_controls='no'">0</xsl:when>
								<xsl:otherwise>1</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="ShowStatusBar" value="0"/>
					<param name="AutoStart">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_autostart='no'">0</xsl:when>
								<xsl:otherwise>1</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="src">
						<xsl:attribute name="value"><xsl:value-of select="$movie.path"/></xsl:attribute>
					</param>
					<param name="windowlessVideo">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_windowless='yes'">1</xsl:when>
								<xsl:otherwise>0</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="AutoSize" value="1" />
					<param name="AutoRewind" value="0" />
					<param name="SendPlayStateChangeEvents" value="1"/>
					<param name="AllowChangeDisplaySize" value="0" />
				</object>
			</xsl:otherwise>
		</xsl:choose>
	

	</div>

<!--

<xsl:if test="$player.type='rp'">
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_rpdiv</xsl:attribute>
		<xsl:attribute name="style">display: block;</xsl:attribute>
		<object>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_rp</xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="$objectID"/>_rp</xsl:attribute>
			<xsl:attribute name="classid">clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA</xsl:attribute>
			<xsl:attribute name="codebase">http://www.real.com/</xsl:attribute>
			<xsl:attribute name="width">100%</xsl:attribute>
			<xsl:attribute name="height">100%</xsl:attribute>
			<param name="src">
				<xsl:attribute name="value"><xsl:value-of select="$movie.path"/></xsl:attribute>
			</param>
			<param name="controls">
				<xsl:attribute name="value">
					<xsl:if test="video_controls='full'">All</xsl:if>
					<xsl:if test="video_controls='mini'">PlayButton</xsl:if>
					<xsl:if test="video_controls='no'">ImageWindow</xsl:if>
				</xsl:attribute>
			</param>
			<embed pluginspage="http://www.real.com/" bgcolor="">
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_rpembed</xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="$objectID"/>_rpembed</xsl:attribute>
				<xsl:attribute name="src"><xsl:value-of select="$movie.path"/></xsl:attribute>
				<xsl:attribute name="width">100%</xsl:attribute>
				<xsl:attribute name="height">100%</xsl:attribute>
				<xsl:attribute name="controls">
					<xsl:if test="video_controls='full'">All</xsl:if>
					<xsl:if test="video_controls='mini'">PlayButton</xsl:if>
					<xsl:if test="video_controls='no'">ImageWindow</xsl:if>
				</xsl:attribute>
			</embed>
		</object>
	</div>
</xsl:if>

-->

</xsl:template>
</xsl:stylesheet>
