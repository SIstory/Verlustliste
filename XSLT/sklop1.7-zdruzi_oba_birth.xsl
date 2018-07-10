<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni TEI/Verlustliste-*.xml -->
    <!-- iz tistih note, ki omenjajo ujetnike, poberem ven podatke za event -->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:person/tei:birth[1]">
        <birth>
            <xsl:apply-templates/>
            <xsl:apply-templates select="following-sibling::tei:birth/tei:settlement"/>
            <xsl:apply-templates select="following-sibling::tei:birth/tei:date"/>
        </birth>
    </xsl:template>
    
    <xsl:template match="tei:person/tei:birth[2]">
        <!-- drugega pa ne procesiram -->
    </xsl:template>
    
</xsl:stylesheet>