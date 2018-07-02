<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni Verlustliste.xml, ki je teiCorpus -->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Seznam izgub prve svetovne vojne za slovenske dežele</title>
                    </titleStmt>
                    <publicationStmt>
                        <publisher>Inštitut za novejšo zgodovino</publisher>
                        <distributor>Raziskovalna infrastruktura slovenskega zgodovinopisja</distributor>
                        <distributor>DARIAH-SI</distributor>
                        <pubPlace>https://github.com/SIstory/Verlustliste</pubPlace>
                        <availability status="free">
                            <licence>http://creativecommons.org/licenses/by/4.0/</licence>
                            <p xml:lang="en">This work is licensed under the <ref
                                target="http://creativecommons.org/licenses/by/4.0/">Creative Commons
                                Attribution 4.0 International License</ref>.</p>
                            <p xml:lang="sl">To delo je ponujeno pod <ref
                                target="http://creativecommons.org/licenses/by/4.0/">Creative Commons
                                Priznanje avtorstva 4.0 mednarodna licenca</ref>.</p>
                        </availability>
                        <date when="2018"/>
                    </publicationStmt>
                    <sourceDesc>
                        <p><ref target="../Verlustliste.xml">TEI Corpus za XML direktorij</ref></p>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <listPerson>
                        <xsl:for-each select="tei:teiCorpus/tei:TEI/tei:text/tei:body/tei:div/tei:p[@xml:id]">
                            <person xml:id="{@xml:id}">
                                <xsl:if test="@sameAs">
                                    <xsl:attribute name="sameAs">
                                        <xsl:value-of select="@sameAs"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <note>
                                    <xsl:apply-templates/>
                                </note>
                            </person>
                        </xsl:for-each>
                    </listPerson>
                </body>
            </text>
        </TEI>
    </xsl:template>
    
    <xsl:template match="tei:country">
        <country>
            <xsl:apply-templates/>
        </country>
    </xsl:template>
    
</xsl:stylesheet>