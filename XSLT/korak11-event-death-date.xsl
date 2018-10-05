<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni TEI/Verlustliste-{Dezela}-SI.xml -->
    <!-- označim datume smrti -->
    
    <xsl:output method="xml"/>
    
    <xsl:param name="months">
        <month n="01">Jän.</month>
        <month n="01">Jänner</month>
        <month n="02">Febr.</month>
        <month n="02">Februar</month>
        <month n="03">März</month>
        <month n="04">April</month>
        <month n="05">Mai</month>
        <month n="06">Juni</month>
        <month n="07">Juli</month>
        <month n="08">Aug.</month>
        <month n="08">August</month>
        <month n="09">Sept.</month>
        <month n="09">September</month>
        <month n="10">Oktober</month>
        <month n="11">November</month>
        <month n="11">Nov.</month>
        <month n="12">Dezember</month>
        <month n="12">Dez.</month>
    </xsl:param>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:event[@type='death']/tei:desc[not(tei:*)][matches(.,'\d{4}')]">
        <desc>
            <xsl:apply-templates select="@*"/>
            <xsl:choose>
                <!-- zapis datuma smrti se v veliki večini primerov začne in konča z oklepajem, zato ga vedno dodam v test match regex -->
                <!-- pattern 12./1. 1915 -->
                <xsl:when test="matches(.,'\(\d{1,2}\.\s?/?\d{1,2}\.\s?\d{4}\)')">
                    <xsl:analyze-string select="." regex="(\d{{1,2}})(\.\s?/?)(\d{{1,2}})(\.\s?)(\d{{4}})">
                        <xsl:matching-substring>
                            <date when="{regex-group(5)}-{format-number(number(regex-group(3)),'00')}-{format-number(number(regex-group(1)),'00')}">
                                <xsl:value-of select="."/>
                            </date>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:when>
                <!-- pattern 12./11. 1914-12./1. 1915 -->
                <xsl:when test="matches(.,'\(\d{1,2}\.\s?/\d{1,2}\.\s?\d{4}\s?-|—\s?\d{1,2}\.\s?/\d{1,2}\.\s?\d{4}\)')">
                    <xsl:analyze-string select="." regex="(\d{{1,2}})(\.\s?/)(\d{{1,2}})(\.\s?)(\d{{4}})(\s?-|—\s?)(\d{{1,2}})(\.\s?/)(\d{{1,2}})(\.\s?)(\d{{4}})">
                        <xsl:matching-substring>
                            <date notBefore="{regex-group(5)}-{format-number(number(regex-group(3)),'00')}-{format-number(number(regex-group(1)),'00')}"
                                  notAfter="{regex-group(11)}-{format-number(number(regex-group(9)),'00')}-{format-number(number(regex-group(7)),'00')}">
                                <xsl:value-of select="."/>
                            </date>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:when>
                <!-- pattern 12./1.-15./12. 1915 -->
                <xsl:when test="matches(.,'\(\d{1,2}\.\s?/\d{1,2}\.\s?(-|—|bis)\s?\d{1,2}\.\s?/\d{1,2}\.\s?\d{4}\)')">
                    <xsl:analyze-string select="." regex="(\d{{1,2}})(\.\s?/)(\d{{1,2}})(\.\s?)(-|—|bis)(\s)?(\d{{1,2}})(\.\s?/)(\d{{1,2}})(\.\s?)(\d{{4}})">
                        <xsl:matching-substring>
                            <date notBefore="{regex-group(11)}-{format-number(number(regex-group(3)),'00')}-{format-number(number(regex-group(1)),'00')}"
                                notAfter="{regex-group(11)}-{format-number(number(regex-group(9)),'00')}-{format-number(number(regex-group(7)),'00')}">
                                <xsl:value-of select="."/>
                            </date>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:when>
                <!-- pattern 12.-15./12. 1915 -->
                <xsl:when test="matches(.,'\(\d{1,2}\.\s?\s?-|—\s?\d{1,2}\.\s?/\d{1,2}\.\s?\d{4}\)')">
                    <xsl:analyze-string select="." regex="(\d{{1,2}})(\.\s?)(\s?-|—\s?)(\d{{1,2}})(\.\s?/)(\d{{1,2}})(\.\s?)(\d{{4}})">
                        <xsl:matching-substring>
                            <date notBefore="{regex-group(8)}-{format-number(number(regex-group(6)),'00')}-{format-number(number(regex-group(1)),'00')}"
                                notAfter="{regex-group(8)}-{format-number(number(regex-group(6)),'00')}-{format-number(number(regex-group(4)),'00')}">
                                <xsl:value-of select="."/>
                            </date>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:when>
                <xsl:when test="matches(.,'\([A-Z][a-zäöü]+\.?\s\d{4}\)')">
                    <xsl:analyze-string select="." regex="([A-Z][a-zäöü]+\.?)(\s)(\d{{4}})">
                        <xsl:matching-substring>
                            <xsl:choose>
                                <xsl:when test="regex-group(1) = $months/tei:month">
                                    <xsl:variable name="month-string" select="regex-group(1)"/>
                                    <xsl:variable name="month-number" select="$months/tei:month[. = $month-string]/@n"/>
                                    <date when="{regex-group(3)}-{$month-number}">
                                        <xsl:value-of select="."/>
                                    </date>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="."/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </desc>
    </xsl:template>
    
</xsl:stylesheet>