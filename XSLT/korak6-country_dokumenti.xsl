<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni TEI/Verlustliste.xml -->
    <!-- ustvaril ločene country dokumente -->
    <!-- izhodiščni dokument nato izbrišem -->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="tei:TEI">
        <xsl:result-document href="Verlustliste-Krain.xml">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Seznam izgub prve svetovne vojne za slovenske dežele</title>
                            <title>Kranjska</title>
                        </titleStmt>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listPerson>
                            <xsl:for-each select="tei:text/tei:body/tei:listPerson/tei:person[tei:name/tei:country = 'Krain']">
                                <xsl:call-template name="person"/>
                            </xsl:for-each>
                        </listPerson>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
        
        <xsl:result-document href="Verlustliste-Steiermark.xml">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Seznam izgub prve svetovne vojne za slovenske dežele</title>
                            <title>Štajerska</title>
                        </titleStmt>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listPerson>
                            <xsl:for-each select="tei:text/tei:body/tei:listPerson/tei:person[tei:name/tei:country = 'Steiermark'][tei:name/tei:region]">
                                <xsl:call-template name="person-light"/>
                            </xsl:for-each>
                        </listPerson>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
        <xsl:result-document href="Verlustliste-Steiermark-region-no.xml">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Seznam izgub prve svetovne vojne za slovenske dežele</title>
                            <title>Štajerska</title>
                            <title>Osebe brez označenega okraja</title>
                        </titleStmt>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listPerson>
                            <xsl:for-each select="tei:text/tei:body/tei:listPerson/tei:person[tei:name/tei:country = 'Steiermark'][not(tei:name/tei:region)]">
                                <xsl:call-template name="person-light"/>
                            </xsl:for-each>
                        </listPerson>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
        
        <xsl:result-document href="Verlustliste-Karnten.xml">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Seznam izgub prve svetovne vojne za slovenske dežele</title>
                            <title>Koroška</title>
                        </titleStmt>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listPerson>
                            <xsl:for-each select="tei:text/tei:body/tei:listPerson/tei:person[tei:name/tei:country = 'Kärnten'][tei:name/tei:region]">
                                <xsl:call-template name="person-light"/>
                            </xsl:for-each>
                        </listPerson>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
        <xsl:result-document href="Verlustliste-Karnten-region-no.xml">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Seznam izgub prve svetovne vojne za slovenske dežele</title>
                            <title>Koroška</title>
                            <title>Osebe brez označenega okraja</title>
                        </titleStmt>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listPerson>
                            <xsl:for-each select="tei:text/tei:body/tei:listPerson/tei:person[tei:name/tei:country = 'Kärnten'][not(tei:name/tei:region)]">
                                <xsl:call-template name="person-light"/>
                            </xsl:for-each>
                        </listPerson>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
        
        <xsl:result-document href="Verlustliste-Kustenland.xml">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Seznam izgub prve svetovne vojne za slovenske dežele</title>
                            <title>Primorska</title>
                        </titleStmt>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listPerson>
                            <xsl:for-each select="tei:text/tei:body/tei:listPerson/tei:person[tei:name/tei:country = 'Küstenland'][tei:name/tei:region]">
                                <xsl:call-template name="person-light"/>
                            </xsl:for-each>
                        </listPerson>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
        <xsl:result-document href="Verlustliste-Kustenland-region-no.xml">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Seznam izgub prve svetovne vojne za slovenske dežele</title>
                            <title>Primorska</title>
                            <title>Osebe brez označenega okraja</title>
                        </titleStmt>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listPerson>
                            <xsl:for-each select="tei:text/tei:body/tei:listPerson/tei:person[tei:name/tei:country = 'Küstenland'][not(tei:name/tei:region)]">
                                <xsl:call-template name="person-light"/>
                            </xsl:for-each>
                        </listPerson>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
        
        <xsl:result-document href="Verlustliste-Istrien.xml">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Seznam izgub prve svetovne vojne za slovenske dežele</title>
                            <title>Istra</title>
                        </titleStmt>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listPerson>
                            <xsl:for-each select="tei:text/tei:body/tei:listPerson/tei:person[tei:name/tei:country = 'Istrien'][tei:name/tei:region]">
                                <xsl:call-template name="person-light"/>
                            </xsl:for-each>
                        </listPerson>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
        <xsl:result-document href="Verlustliste-Istrien-region-no.xml">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Seznam izgub prve svetovne vojne za slovenske dežele</title>
                            <title>Istra</title>
                            <title>Osebe brez označenega okraja</title>
                        </titleStmt>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listPerson>
                            <xsl:for-each select="tei:text/tei:body/tei:listPerson/tei:person[tei:name/tei:country = 'Istrien'][not(tei:name/tei:region)]">
                                <xsl:call-template name="person-light"/>
                            </xsl:for-each>
                        </listPerson>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
        <!-- Vsi ostali primeri bi morali veljati za Goriško -->
        <xsl:result-document href="Verlustliste-Gorz.xml">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Seznam izgub prve svetovne vojne za slovenske dežele</title>
                            <title>Goriška in Gradiščanska</title>
                        </titleStmt>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listPerson>
                            <xsl:for-each select="tei:text/tei:body/tei:listPerson/tei:person[not(tei:name/tei:country = 'Krain') and not(tei:name/tei:country = 'Steiermark') and not(tei:name/tei:country = 'Kärnten') and not(tei:name/tei:country = 'Küstenland') and not(tei:name/tei:country = 'Istrien')][tei:name/tei:region]">
                                <xsl:call-template name="person-light"/>
                            </xsl:for-each>
                        </listPerson>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
        <xsl:result-document href="Verlustliste-Gorz-region-no.xml">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Seznam izgub prve svetovne vojne za slovenske dežele</title>
                            <title>Goriška in Gradiščanska</title>
                            <title>Osebe brez označenega okraja</title>
                        </titleStmt>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                        <xsl:copy-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listPerson>
                            <xsl:for-each select="tei:text/tei:body/tei:listPerson/tei:person[not(tei:name/tei:country = 'Krain') and not(tei:name/tei:country = 'Steiermark') and not(tei:name/tei:country = 'Kärnten') and not(tei:name/tei:country = 'Küstenland') and not(tei:name/tei:country = 'Istrien')][not(tei:name/tei:region)]">
                                <xsl:call-template name="person-light"/>
                            </xsl:for-each>
                        </listPerson>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template name="person">
        <person xml:id="{@xml:id}">
            <xsl:if test="@sameAs">
                <xsl:attribute name="sameAs">
                    <xsl:value-of select="@sameAs"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:analyze-string select="tei:note[1]" regex="^(.*?)(,)" flags="m">
                <xsl:matching-substring>
                    <persName>
                        <xsl:choose>
                            <xsl:when test="contains(regex-group(1),' ')">
                                <xsl:analyze-string select="regex-group(1)" regex="^(.*?)(\s)" flags="m">
                                    <xsl:matching-substring>
                                        <surname>
                                            <xsl:value-of select="regex-group(1)"/>
                                        </surname>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                        <forename>
                                            <xsl:value-of select="."/>
                                        </forename>
                                    </xsl:non-matching-substring>
                                </xsl:analyze-string>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="regex-group(1)"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </persName>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <affiliation>
                        <xsl:value-of select="normalize-space(.)"/>
                    </affiliation>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
            <birth>
                <xsl:copy-of select="tei:name/tei:country"/>
                <xsl:if test="tei:name/tei:region">
                    <xsl:copy-of select="tei:name/tei:region"/>
                </xsl:if>
            </birth>
            <xsl:copy-of select="tei:note[2]"/>
        </person>
    </xsl:template>
    
    <xsl:template name="person-light">
        <person xml:id="{@xml:id}">
            <xsl:if test="@sameAs">
                <xsl:attribute name="sameAs">
                    <xsl:value-of select="@sameAs"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:copy-of select="tei:note[1]"/>
            <birth>
                <xsl:copy-of select="tei:name/tei:country"/>
                <xsl:if test="tei:name/tei:region">
                    <xsl:copy-of select="tei:name/tei:region"/>
                </xsl:if>
            </birth>
            <xsl:copy-of select="tei:note[2]"/>
        </person>
    </xsl:template>
    


    
</xsl:stylesheet>