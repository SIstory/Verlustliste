<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni TEI/Verlustliste-*.xml -->
    <!-- Element country, region in settlement dam v skupni element placeName (zaradi naknadne povezave na ortsrepertorium datoteke) -->
    <!-- iz seznama krajev TEI/*-places.xml poberem ven morebitne zamenjave kodiranja krajevnih imen (npr. namesto region je settlement) -->
    <!-- POZOR: transformacija traja zelo dolgo (za Kranjsko npr. 23 minut) -->
    <!-- NUJNO določi datoteko TEI/places-*.xml -->
    <xsl:param name="listPlace">../TEI/places-Steiermark.xml</xsl:param>
    <!-- NUJNO: pri Kranjski je seznam za vse osebe, za Štajersko, Koroško in Primorsko pa samo za mrtve, zato pred tem nastavi parameter -->
    <xsl:param name="only-death-persons">true</xsl:param>
    <!-- 
        Statutory city / Mesto z lastnim statutom / Stadt mit eigenem Statut
        Administrative district / Politični okraj / Politischer Bezirk
            Judicial district / Sodni okraj / Gerichtsbezirk
                Municipality / Občina / Gemeinde
                    Place / Kraj / Ort
    -->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:birth[if ($only-death-persons='true') then parent::tei:person[tei:event[@type='death']] else parent::tei:person]">
        <xsl:variable name="personID" select="parent::tei:person/@xml:id"/>
        <birth>
            <xsl:apply-templates select="@*"/>
            <placeName>
                <xsl:for-each select="tei:*[not(self::tei:date)]">
                    <xsl:variable name="elementName" select="name(.)"/>
                    <xsl:variable name="elementValue" select="."/>
                    <xsl:choose>
                        <xsl:when test="self::tei:country">
                            <country>
                                <xsl:apply-templates/>
                            </country>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="document($listPlace)//tei:place[@type = $elementName][tei:idno[tokenize(normalize-space(.),' ') = $personID]]">
                                    <xsl:for-each select="document($listPlace)//tei:place[@type = $elementName][tei:idno[tokenize(normalize-space(.),' ') = $personID]]">
                                        <xsl:choose>
                                            <xsl:when test=".[@subtype]">
                                                <xsl:variable name="subtypeValue" select="@subtype"/>
                                                <xsl:choose>
                                                    <xsl:when test="$subtypeValue = 'region'">
                                                        <region>
                                                            <xsl:value-of select="$elementValue"/>
                                                        </region>
                                                    </xsl:when>
                                                    <xsl:when test="$subtypeValue = 'settlement'">
                                                        <settlement>
                                                            <xsl:value-of select="$elementValue"/>
                                                        </settlement>
                                                    </xsl:when>
                                                    <xsl:when test="$subtypeValue = 'sodni'">
                                                        <region type="judicial">
                                                            <xsl:value-of select="$elementValue"/>
                                                        </region>
                                                    </xsl:when>
                                                    <xsl:when test="$subtypeValue = 'občina'">
                                                        <xsl:element name="{$elementName}">
                                                            <xsl:attribute name="type">municipality</xsl:attribute>
                                                            <xsl:value-of select="$elementValue"/>
                                                        </xsl:element>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:message>Unknown @subtype <xsl:value-of select="$subtypeValue"/></xsl:message>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:element name="{$elementName}">
                                                    <xsl:value-of select="$elementValue"/>
                                                </xsl:element>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:element name="{$elementName}">
                                        <xsl:value-of select="."/>
                                    </xsl:element>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </placeName>
            <xsl:apply-templates select="tei:date"/>
        </birth>
    </xsl:template>
    
</xsl:stylesheet>