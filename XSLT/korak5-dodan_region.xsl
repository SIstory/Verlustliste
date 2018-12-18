<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni TEI/Verlustliste.xml -->
    
    <xsl:output method="xml"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:person/tei:note[2]">
        <xsl:choose>
            <xsl:when test="string-length(.) = 0">
                <xsl:copy-of select="."/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="contains(.,',')">
                        <xsl:choose>
                            <xsl:when test="matches(.,'^\d{4},','m')">
                                <xsl:copy-of select="."/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:analyze-string select="." regex="^(.*?)(,)" flags="m">
                                    <xsl:matching-substring>
                                        <name><region><xsl:value-of select="regex-group(1)"/></region></name>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                        <note><xsl:value-of select="normalize-space(.)"/></note>
                                    </xsl:non-matching-substring>
                                </xsl:analyze-string>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="contains(.,';')">
                                <xsl:choose>
                                    <xsl:when test="matches(.,'^\d{4};','m')">
                                        <xsl:copy-of select="."/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:analyze-string select="." regex="^(.*?)(;)" flags="m">
                                            <xsl:matching-substring>
                                                <name><region><xsl:value-of select="regex-group(1)"/></region></name>
                                            </xsl:matching-substring>
                                            <xsl:non-matching-substring>
                                                <note><xsl:value-of select="normalize-space(.)"/></note>
                                            </xsl:non-matching-substring>
                                        </xsl:analyze-string>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:copy-of select="."/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>