<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="documentsList">
        <!-- naredim v direktoriju txt datoteke .txt, pri katerih očistim html tage -->
        <xsl:for-each select="ref">
            <xsl:variable name="uri" select="concat('../',.)"/>
            <xsl:variable name="document" select="concat('xml/',substring-before(tokenize(.,'/')[last()],'.txt'),'.xml')"/>
            <xsl:variable name="besedilo" select="unparsed-text($uri)"/>
            <xsl:variable name="id" select="substring-before(tokenize(.,'/')[last()],'.txt')"/>
            <xsl:variable name="id-date" select="tokenize(substring-before(tokenize(.,'/')[last()],'.txt'),'_')[1]"/>
            <xsl:variable name="leto" select="substring($id-date,1,4)"/>
            <xsl:variable name="mesec" select="substring($id-date,5,2)"/>
            <xsl:variable name="dan" select="substring($id-date,7,2)"/>
            <xsl:variable name="datum" select="concat($leto,'-',$mesec,'-',$dan)"/>
            <xsl:variable name="volume1" select="tokenize(substring-before(tokenize(.,'/')[last()],'.txt'),'_')[2]"/>
            <xsl:variable name="volume2" select="tokenize(substring-before(tokenize(.,'/')[last()],'.txt'),'_')[3]"/>
            <xsl:result-document href="{$document}">
                <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de" xml:id="{concat('vll.',$id)}">
                    <xsl:variable name="korak1">
                        <xsl:analyze-string select="$besedilo" regex="\n">
                            <xsl:non-matching-substring>
                                <p>
                                    <xsl:value-of select="normalize-space(.)"/>
                                </p>
                            </xsl:non-matching-substring>
                        </xsl:analyze-string>
                    </xsl:variable>
                    <xsl:variable name="korak2">
                        <xsl:for-each select="$korak1/tei:p">
                            <xsl:choose>
                                <xsl:when test="matches(.,'\[\sVerlustliste\s\-\s\d{8}')">
                                    <pb>
                                        <xsl:attribute name="n">
                                            <xsl:analyze-string select="." regex="Seite\s(\d+)">
                                                <xsl:matching-substring>
                                                    <xsl:value-of select="regex-group(1)"/>
                                                </xsl:matching-substring>
                                            </xsl:analyze-string>
                                        </xsl:attribute>
                                    </pb>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy-of select="."/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:variable name="korak3">
                        <xsl:for-each select="$korak2/tei:*">
                            <xsl:choose>
                                <xsl:when test="self::tei:p">
                                    <xsl:choose>
                                        <xsl:when test="number(.) = number(preceding::tei:pb[1]/@n)">
                                            <!-- ga izbrišem -->
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:copy-of select="."/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="self::tei:pb">
                                    <pb n="{@n}">
                                        <!-- možen še zapis, ki usmerja direktno na sliko, npr. http://anno.onb.ac.at/cgi-content/annoshow?call=vll|19150617|3|33.0|0
                                             pri čemer je najprej datum, potem stran, nato zoom in na koncu še 0 -->
                                        <xsl:attribute name="facs">
                                            <xsl:value-of select="concat('http://anno.onb.ac.at/cgi-content/anno?aid=vll&amp;datum=',$id-date,'&amp;seite=',@n,'&amp;zoom=33')"/>
                                        </xsl:attribute> 
                                    </pb>
                                    <ab><ref target="{concat('http://anno.onb.ac.at/cgi-content/anno?aid=vll&amp;datum=',$id-date,'&amp;seite=',@n,'&amp;zoom=33')}">
                                        <xsl:value-of select="concat('[ Verlustliste - ',$id-date,' - Seite ',@n,' ]')"/>
                                    </ref></ab>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy-of select="."/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:variable name="korak4">
                        <xsl:for-each select="$korak3/tei:*">
                            <xsl:choose>
                                <xsl:when test="self::tei:p">
                                    <xsl:choose>
                                        <xsl:when test="string-length(.) gt 39 and
                                            (not(contains(.,' tot')) or not(contains(.,'verw')) or not(contains(.,'kriegsgef'))) and
                                            string-length(following-sibling::tei:p[1]) lt 40 and
                                            (contains(following-sibling::tei:p[1],' tot') or contains(following-sibling::tei:p[1],'verw') or contains(following-sibling::tei:p[1],'kriegsgef'))">
                                            <p>
                                                <xsl:value-of select="concat(.,' ',following-sibling::tei:p[1])"/>
                                            </p>
                                        </xsl:when>
                                        <xsl:when test="string-length(.) lt 40 and
                                            (contains(.,' tot') or contains(.,'verw') or contains(.,'kriegsgef')) and
                                            string-length(preceding-sibling::tei:p[1]) gt 39 and
                                            (not(contains(preceding-sibling::tei:p[1],' tot')) or not(contains(preceding-sibling::tei:p[1],'verw')) or not(contains(preceding-sibling::tei:p[1],'kriegsgef')))">
                                            <!-- ga brišem, ker sem ga prej združil s predhodnim odstavkom -->
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:copy-of select="."/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy-of select="."/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:variable>
                    
                    <teiHeader xml:lang="sl">
                        <fileDesc>
                            <titleStmt>
                                <title>Seznam izgub Avstro-Ogrske med prvo svetovno vojno</title>
                                <title>
                                    <xsl:value-of select="format-date(xs:date($datum),'[D]. [M]. [Y]','en',(),())"/>
                                </title>
                                <title>
                                    <xsl:value-of select="concat('št. ',$volume1)"/>
                                </title>
                                <xsl:if test="string-length($volume2) gt 0">
                                    <title>
                                        <xsl:value-of select="concat('št. ',$volume2)"/>
                                    </title>
                                </xsl:if>
                            </titleStmt>
                            <publicationStmt>
                                <publisher>Inštitut za novejšo zgodovino</publisher>
                                <distributor>Raziskovalna infrastruktura slovenskega zgodovinopisja</distributor>
                                <distributor>DARIAH-SI</distributor>
                                <pubPlace>https://github.com/SIstory/Verlustliste</pubPlace>
                                <availability status="free">
                                    <licence>http://creativecommons.org/licenses/by/4.0/</licence>
                                    <p xml:lang="en">This work is licensed under the <ref target="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</ref>.</p>
                                    <p xml:lang="sl">To delo je ponujeno pod <ref target="http://creativecommons.org/licenses/by/4.0/">Creative Commons Priznanje avtorstva 4.0 mednarodna licenca</ref>.</p>
                                </availability>
                                <date when="2017"/>
                            </publicationStmt>
                            <sourceDesc>
                                <biblStruct>
                                    <monogr>
                                        <title>Verlustliste</title>
                                        <imprint>
                                            <biblScope unit="issue">
                                                <xsl:value-of select="$volume1"/>
                                            </biblScope>
                                            <xsl:if test="string-length($volume2) gt 0">
                                                <biblScope unit="issue">
                                                    <xsl:value-of select="$volume2"/>
                                                </biblScope>
                                            </xsl:if>
                                            <date when="{$datum}"/>
                                        </imprint>
                                    </monogr>
                                    <ref target="http://anno.onb.ac.at/cgi-content/anno?aid=vll">ANNO Historische österreichische Zeitungen und Zeitschriften</ref>
                                </biblStruct>
                            </sourceDesc>
                        </fileDesc>
                        <revisionDesc>
                            <change when="{current-date()}">
                                <name>Andrej Pančur</name>: konverzija txt2tei </change>
                        </revisionDesc>
                    </teiHeader>
                    <text>
                        <body>
                            <div>
                                <xsl:copy-of select="$korak4"/>
                            </div>
                        </body>
                    </text>
                </TEI>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>