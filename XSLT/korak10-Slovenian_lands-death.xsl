<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni TEI/Verlustliste-Dezela-SI.xml -->
    <!-- Za Štajersko, Koroško, in primorske dežele ustvri seznam oseb iz slovenskih delov dežel, za katere je bilo prej označeno, da so umrli -->
    <!-- rezultat preimenujem v TEI/Verlustliste-Dezela-SI-death.xml -->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="document-uri" select="document-uri(.)"/>
    <xsl:variable name="document-uri-filename" select="(tokenize($document-uri,'/'))[last()]"/>
    
    <xsl:template match="/">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:copy-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]"/>
                        <xsl:copy-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[2]"/>
                        <title>Seznam smrtnih žrtev</title>
                    </titleStmt>
                    <xsl:copy-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                    <sourceDesc>
                        <p>
                            <ref target="../TEI/{$document-uri-filename}"/>
                        </p>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <listPerson>
                        <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:listPerson/tei:person[tei:event/@type='death']">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </listPerson>
                </body>
            </text>
        </TEI>
    </xsl:template>
    
    
</xsl:stylesheet>