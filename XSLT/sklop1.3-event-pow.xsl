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
    
    <xsl:output method="xml"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:person/tei:note[1]">
        <xsl:analyze-string select="." regex="^(.*?)(kriegsgef\.)(.*)$" flags="m">
            <xsl:matching-substring>
                <xsl:if test="string-length(regex-group(1)) gt 0">
                    <note>
                        <xsl:value-of select="regex-group(1)"/>
                    </note>
                </xsl:if>
                <event type="pow">
                    <label>
                        <xsl:value-of select="regex-group(2)"/>
                    </label>
                    <xsl:if test="string-length(normalize-space(regex-group(3))) gt 0">
                        <desc>
                            <xsl:value-of select="normalize-space(regex-group(3))"/>
                        </desc>
                    </xsl:if>
                </event>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <note>
                    <xsl:value-of select="."/>
                </note>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    
</xsl:stylesheet>