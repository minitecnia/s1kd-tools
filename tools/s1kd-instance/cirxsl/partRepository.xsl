<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:template match="spareDescr[partRef]">
    <xsl:variable name="partNumberValue" select="partRef/@partNumberValue"/>
    <xsl:variable name="manufacturerCodeValue" select="partRef/@manufacturerCodeValue"/>
    <xsl:variable name="partIdent" select="//partIdent[@partNumberValue = $partNumberValue and @manufacturerCodeValue = $manufacturerCodeValue]"/>
    <xsl:variable name="partSpec" select="$partIdent/parent::partSpec"/>
    <spareDescr>
      <xsl:choose>
        <xsl:when test="$partSpec">
          <xsl:apply-templates select="@*"/>
          <xsl:apply-templates select="$partSpec/itemIdentData/descrForPart"/>
          <xsl:apply-templates select="$partSpec/itemIdentData/shortName"/>
          <xsl:apply-templates select="catalogSeqNumberRef|natoStockNumber|identNumber|partRef|functionalItemRef|materialSetRef"/>
          <xsl:apply-templates select="reqQuantity"/>
          <xsl:apply-templates select="remarks|footnoteRemarks"/>
          <xsl:apply-templates select="embeddedSpareDescr"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="@*|node()"/>
        </xsl:otherwise>
      </xsl:choose>
    </spareDescr>
  </xsl:template>

  <xsl:template match="descrForPart">
    <name>
      <xsl:apply-templates/>
    </name>
  </xsl:template>

</xsl:stylesheet>