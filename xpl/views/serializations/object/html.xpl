<?xml version="1.0" encoding="UTF-8"?>
<!--
	Copyright (C) 2014 Ethan Gruber
	Numishare
	Apache License 2.0
	
-->
<p:config xmlns:p="http://www.orbeon.com/oxf/pipeline" xmlns:oxf="http://www.orbeon.com/oxf/processors">
	<p:param type="input" name="data"/>
	<p:param type="output" name="data"/>
	
	<p:processor name="oxf:unsafe-xslt">
		<p:input name="data" href="#data"/>
		<p:input name="config">
			<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
				<xsl:template match="/">
					<recordType>
						<xsl:choose>
							<xsl:when test="*/namespace-uri()='http://nomisma.org/nudsHoard'">nudsHoard</xsl:when>
							<xsl:when test="*/namespace-uri()='http://nomisma.org/nuds'">nuds</xsl:when>
						</xsl:choose>
					</recordType>
				</xsl:template>
			</xsl:stylesheet>
		</p:input>
		<p:output name="data" id="recordType"/>
	</p:processor>
	
	<p:choose href="#recordType">
		<p:when test="recordType='nudsHoard'">
			<p:processor name="oxf:pipeline">
				<p:input name="data" href="#data"/>
				<p:input name="config" href="../nudsHoard/html.xpl"/>
				<p:output name="data" ref="data"/>
			</p:processor>
		</p:when>
		<!-- if it is a coin type record, then execute an ASK query -->
		<p:when test="recordType='nuds'">
			<p:processor name="oxf:pipeline">
				<p:input name="data" href="#data"/>
				<p:input name="config" href="../nuds/html.xpl"/>
				<p:output name="data" ref="data"/>
			</p:processor>
		</p:when>		
	</p:choose>
</p:config>
