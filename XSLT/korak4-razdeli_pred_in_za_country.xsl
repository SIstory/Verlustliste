<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni TEI/Verlustliste.xml -->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:note[tei:country]">
        <xsl:apply-templates mode="razdruzevanje"/>
    </xsl:template>
    
    <!-- mode govori-var4-razdruzevanje:
         example at http://stackoverflow.com/questions/4215965/xslt-split-at-child-node 
         1. The use of the identity rule to copy every node as-is.
    -->
    <xsl:template match="node()|@*" mode="razdruzevanje">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="razdruzevanje"/>
        </xsl:copy>
    </xsl:template>
    <!-- 2. The overriding of the identity rule with templates for processing only specific nodes -->
    <xsl:template match="/*" mode="razdruzevanje">
        <xsl:apply-templates mode="razdruzevanje"/>
    </xsl:template>
    <!-- 3. Using 1. and 2. above. -->
    <xsl:template match="tei:note[tei:country]/text()" mode="razdruzevanje">
        <note><xsl:copy-of select="."/></note>
    </xsl:template>
    
    
    
</xsl:stylesheet>