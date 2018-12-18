<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni places-*.xml -->
    <!-- začasna pretvorba: potrebna zaradi nedosledno označenega places-*.xml dokumenta (namesto geonames bi se lahko že takoj dajalo povezave na krajevne repertorije) -->
    <!-- glede na geonames id iz ustreznega krajevnega repertorija pobere povezave na njihov identifikator -->
    <!-- NUJNO pred tem uredi:
            - position izhodiščnega listPlace/place[@type='country']
    -->
    <!-- v spodnjem parametru dodaj povezavo na zaželjeni krajevni reperotrij -->
    <xsl:param name="OR-document">../TEI/Ortsrepertorium/OR-Ist-1910-SI.xml</xsl:param>
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- ustrezno spremeni position za listPlace/place -->
    <xsl:template match="tei:listPlace/tei:place[6]//tei:place[not(@corresp)][tei:location]">
        <place>
            <xsl:apply-templates select="@*"/>
            <xsl:variable name="geonamesId" select="substring-before(substring-after(tei:location/tei:geo,'http://www.geonames.org/'),'/')"/>
            <xsl:variable name="OR-id">
                <xsl:for-each select="document($OR-document)//tei:place[tei:placeName[@key = $geonamesId]]/@xml:id">
                    <xsl:value-of select="."/>
                    <xsl:if test="position() != last()">
                        <xsl:text> </xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <xsl:attribute name="corresp">
                <xsl:value-of select="$OR-id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </place>
    </xsl:template>
    
</xsl:stylesheet>