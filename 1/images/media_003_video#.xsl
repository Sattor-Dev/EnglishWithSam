<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	media_003_video#.xsl
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

<xsl:variable name="mpath">
	<xsl:if test="vfile='yes'"><xsl:value-of select="video_uri"/></xsl:if>
	<xsl:if test="vURL='yes'"><xsl:value-of select="video_url"/></xsl:if>
</xsl:variable>
<xsl:variable name="plr">
	<xsl:if test="player!='auto'"><xsl:value-of select="player"/></xsl:if>
	<xsl:if test="player='auto'">
		<xsl:choose>
			<xsl:when test="contains($mpath,'.mov')">qtp</xsl:when>
			<xsl:when test="contains($mpath,'.3gp')">qtp</xsl:when>
			<xsl:when test="contains($mpath,'.rm')">rp</xsl:when>
			<xsl:when test="contains($mpath,'.ram')">rp</xsl:when>
			<xsl:when test="contains($mpath,'.rpm')">rp</xsl:when>
			<xsl:otherwise>wmp</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:variable>

<xsl:choose>
	<xsl:when test="$mpath=''">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td bgcolor="#FFFFFF" valign="middle" align="center">
					<xsl:attribute name="style">border: #CCCCCC 2px solid</xsl:attribute>
					<img border="0">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>media_003_video.gif</xsl:attribute>
					</img>
					<div style="font-family: Verdana, Arial, sans-serif; font-size:10px; padding-top:10px; text-align: center"><xsl:value-of select="hidden.label.nosrc"/></div>
				</td>
			</tr>
		</table>
	</xsl:when>
	<xsl:otherwise>
		<xsl:if test="$plr='rp'">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td bgcolor="#EEEEEE" valign="middle" align="center">
					<img border="0">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>real.gif</xsl:attribute>
					</img>
					<div style="font-family: Verdana, Arial, sans-serif; font-size:10px; padding-top:10px; text-align: center"><xsl:value-of select="$mpath"/></div>
					</td>
				</tr>
				<xsl:if test="video_controls!='no'">
					<tr>
						<td valign="bottom" bgcolor="#EEEEEE">
							<xsl:attribute name="style">background-image: url(<xsl:value-of select="$imagesFolder"/>real_bg.gif); background-repeat: repeat-x; background-position: bottom;</xsl:attribute>
							<table width="100%" height="39" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td align="left">
										<img border="0">
											<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>real_left.gif</xsl:attribute>
										</img>
									</td>
									<td align="right">
										<img border="0">
											<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>real_right.gif</xsl:attribute>
										</img>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</xsl:if>
			</table>
		</xsl:if>
		<xsl:if test="$plr='wmp'">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<xsl:if test="video_windowless='yes'">
						<td bgcolor="#EEEEEE" valign="middle" align="center">
						<img border="0">
							<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>wmp_wl.gif</xsl:attribute>
						</img>
						<div style="font-family: Verdana, Arial, sans-serif; font-size:10px; padding-top:10px; text-align: center"><xsl:value-of select="$mpath"/></div>
						</td>
					</xsl:if>
					<xsl:if test="video_windowless='no'">
						<td bgcolor="#000000" valign="middle" align="center">
						<img border="0">
							<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>wmp_nr.gif</xsl:attribute>
						</img>
						<div style="font-family: Verdana, Arial, sans-serif; font-size:10px; color: #FFFFFF; padding-top:10px; text-align: center"><xsl:value-of select="$mpath"/></div>
						</td>
					</xsl:if>
				</tr>
				<xsl:if test="video_controls!='no'">
					<xsl:if test="video_controls='mini'">
						<tr>
							<td valign="bottom">
								<xsl:attribute name="bgcolor">
									<xsl:if test="video_windowless='yes'">#EEEEEE</xsl:if>
									<xsl:if test="video_windowless='no'">#000000</xsl:if>
								</xsl:attribute>
								<xsl:attribute name="style">background-image: url(<xsl:value-of select="$imagesFolder"/>wmp_mini_bg.gif); background-repeat: repeat-x; background-position: bottom;</xsl:attribute>
								<table width="100%" height="45" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td align="left">
											<img border="0">
												<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>wmp_mini_left.gif</xsl:attribute>
											</img>
										</td>
										<td align="right">
											<img border="0">
												<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>wmp_mini_right.gif</xsl:attribute>
											</img>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="video_controls='full'">
						<tr>
							<td valign="bottom" bgcolor="#EEEEEE">
								<xsl:attribute name="style">background-image: url(<xsl:value-of select="$imagesFolder"/>wmp_full_bg.gif); background-repeat: repeat-x; background-position: bottom;</xsl:attribute>
								<table width="100%" height="45" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td align="left">
											<img border="0">
												<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>wmp_full_left.gif</xsl:attribute>
											</img>
										</td>
										<td align="right">
											<img border="0">
												<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>wmp_full_right.gif</xsl:attribute>
											</img>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</xsl:if>
				</xsl:if>
			</table>
		</xsl:if>
		<xsl:if test="$plr='qtp'">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td bgcolor="#EEEEEE" valign="middle" align="center">
					<img border="0">
						<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>quicktime.gif</xsl:attribute>
					</img>
					<div style="font-family: Verdana, Arial, sans-serif; font-size:10px; padding-top:10px; text-align: center"><xsl:value-of select="$mpath"/></div>
					</td>
				</tr>
				<xsl:if test="video_controls!='no'">
					<tr>
						<td valign="bottom" bgcolor="#EEEEEE">
							<xsl:attribute name="style">background-image: url(<xsl:value-of select="$imagesFolder"/>qt_bg.gif); background-repeat: repeat-x; background-position: bottom;</xsl:attribute>
							<table width="100%" height="16" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td align="left">
										<img border="0">
											<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>qt_left.gif</xsl:attribute>
										</img>
									</td>
									<td align="right">
										<img border="0">
											<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>qt_right.gif</xsl:attribute>
										</img>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</xsl:if>
			</table>
		</xsl:if>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>
