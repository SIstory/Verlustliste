<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni TEI/Verlustliste-*.xml -->
    <!-- dodam source atribut: povezava na izvorni Verlustliste -->
    
    <xsl:output method="xml"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:variable name="persons">
        <xsl:for-each select="document('../Verlustliste.xml')/tei:teiCorpus/tei:TEI/tei:text/tei:body/tei:div/tei:p[@xml:id]">
            <person id="{@xml:id}">
                <xsl:value-of select="preceding::tei:pb[1]/@facs"/>
            </person>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:template match="tei:person">
        <xsl:variable name="ID" select="@xml:id"/>
        <person xml:id="{@xml:id}">
            <xsl:if test="@sameAs">
                <xsl:attribute name="sameAs">
                    <xsl:value-of select="@sameAs"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="source">
                <xsl:value-of select="$persons/tei:person[@id = $ID]"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </person>
    </xsl:template>
    
    
</xsl:stylesheet>