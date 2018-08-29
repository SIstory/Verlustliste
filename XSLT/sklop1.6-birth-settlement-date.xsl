<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni TEI/Verlustliste-*.xml -->
    <!-- v preostalem besedilu note, iz katerega sem prej izločiml oznake o ujetnikih, ranjencih in umrlih,
         označi, letnico rojstva in kraj rojstva -->
    
    <xsl:output method="xml"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:person/tei:note[1]">
        <xsl:analyze-string select="." regex="^(.*?)(\d{{4}})(.*)$" flags="m">
            <xsl:matching-substring>
                <birth>
                    <xsl:if test="string-length(regex-group(1)) gt 0">
                        <settlement>
                            <xsl:value-of select="regex-group(1)"/>
                        </settlement>
                    </xsl:if>
                    <date>
                        <xsl:value-of select="regex-group(2)"/>
                        <xsl:value-of select="normalize-space(regex-group(3))"/>
                    </date>
                </birth>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <birth>
                    <settlement>
                        <xsl:value-of select="."/>
                    </settlement>
                </birth>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    
</xsl:stylesheet>