<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni TEI/Verlustliste-*.xml -->
    <!-- affiliation razdelim na socecStatus (Charge - čin) in affiliation -->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:affiliation">
        <xsl:analyze-string select="." regex="^(.*?)(,)" flags="m">
            <xsl:matching-substring>
                <socecStatus>
                    <xsl:value-of select="regex-group(1)"/>
                </socecStatus>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <affiliation>
                    <xsl:value-of select="normalize-space(.)"/>
                </affiliation>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    
</xsl:stylesheet>