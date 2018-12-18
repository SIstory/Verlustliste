<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni TEI/Verlustliste-Dezela.xml.xml -->
    <!-- iz obstoječih birth/region ustvari seznam listPlace -->
    <!-- nujno vstavi še parameter dežele -->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:copy-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]"/>
                        <xsl:copy-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[2]"/>
                        <title>Seznam okrajev</title>
                    </titleStmt>
                    <xsl:copy-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                    <xsl:copy-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <listPlace>
                        <xsl:for-each-group select="tei:TEI/tei:text/tei:body/tei:listPerson/tei:person" group-by="tei:birth/tei:region">
                            <xsl:sort select="current-grouping-key()"/>
                            <place>
                                <placeName>
                                    <xsl:value-of select="current-grouping-key()"/>
                                </placeName>
                                <xsl:for-each select="current-group()">
                                    <idno>
                                        <xsl:value-of select="@xml:id"/>
                                    </idno>
                                </xsl:for-each>
                            </place>
                        </xsl:for-each-group>
                    </listPlace>
                </body>
            </text>
        </TEI>
    </xsl:template>
    
    
</xsl:stylesheet>