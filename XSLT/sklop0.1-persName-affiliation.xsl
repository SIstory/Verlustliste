<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni TEI/Verlustliste-*-SI.xml -->
    <!-- prvi note razdelim na persName in affiliation -->
    <!-- nato na roke preveri, če so imena in priimki pravilno razdeljeni -->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:person/tei:note[1]">
        <xsl:analyze-string select="." regex="^(.*?)(,)" flags="m">
            <xsl:matching-substring>
                <persName>
                    <xsl:analyze-string select="regex-group(1)" regex="^(.*?)(\s)" flags="m">
                        <xsl:matching-substring>
                            <surname>
                                <xsl:value-of select="regex-group(1)"/>
                            </surname>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <forename>
                                <xsl:value-of select="normalize-space(.)"/>
                            </forename>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </persName>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <affiliation>
                    <xsl:value-of select="normalize-space(.)"/>
                </affiliation>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    
</xsl:stylesheet>