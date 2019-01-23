<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0">

  <!-- Add xlink attributes to linking elements. -->
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="dmRef">
    <xsl:copy>
      <xsl:attribute name="xlink:type">simple</xsl:attribute>
      <xsl:attribute name="xlink:href">
        <xsl:apply-templates select="dmRefIdent" mode="xlink"/>
      </xsl:attribute>
      <xsl:attribute name="xlink:title">
        <xsl:apply-templates select="dmRefAddressItems/dmTitle" mode="xlink"/>
      </xsl:attribute>
      <xsl:attribute name="xlink:show">
        <xsl:choose>
          <xsl:when test="behavior">
            <xsl:apply-templates select="behavior" mode="xlink"/>
          </xsl:when>
          <xsl:otherwise>replace</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="refdm">
    <xsl:copy>
      <xsl:attribute name="xlink:type">simple</xsl:attribute>
      <xsl:attribute name="xlink:href">
        <xsl:choose>
          <xsl:when test="dmcextension">DME-</xsl:when>
          <xsl:otherwise>DMC-</xsl:otherwise>
        </xsl:choose>
        <xsl:if test="dmcextension">
          <xsl:apply-templates select="dmcextension" mode="xlink"/>
          <xsl:text>-</xsl:text>
        </xsl:if>
        <xsl:apply-templates select="avee" mode="xlink"/>
      </xsl:attribute>
      <xsl:attribute name="xlink:title">
        <xsl:apply-templates select="dmtitle" mode="xlink"/>
      </xsl:attribute>
      <xsl:attribute name="xlink:show">replace</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*" mode="xlink">
    <xsl:apply-templates mode="xlink"/>
  </xsl:template>

  <xsl:template match="dmRefIdent" mode="xlink">
    <xsl:text>URN:S1000D:</xsl:text>
    <xsl:choose>
      <xsl:when test="identExtension">
        <xsl:text>DME-</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>DMC-</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="identExtension">
      <xsl:apply-templates select="identExtension" mode="xlink"/>
      <xsl:text>-</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="dmCode" mode="xlink"/>
  </xsl:template>

  <xsl:template match="identExtension" mode="xlink">
    <xsl:value-of select="@extensionProducer"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="@extensionCode"/>
  </xsl:template>

  <xsl:template match="dmCode" mode="xlink">
    <xsl:value-of select="@modelIdentCode"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="@systemDiffCode"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="@systemCode"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="@subSystemCode"/>
    <xsl:value-of select="@subSubSystemCode"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="@assyCode"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="@disassyCode"/>
    <xsl:value-of select="@disassyCodeVariant"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="@infoCode"/>
    <xsl:value-of select="@infoCodeVariant"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="@itemLocationCode"/>
    <xsl:if test="@learnCode and @learnEventCode">
      <xsl:text>-</xsl:text>
      <xsl:value-of select="@learnCode"/>
      <xsl:value-of select="@learnEventCode"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="avee" mode="xlink">
    <xsl:value-of select="modelic"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="sdc"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="chapnum"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="section"/>
    <xsl:value-of select="subsect"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="subject"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="discode"/>
    <xsl:value-of select="discodev"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="incode"/>
    <xsl:value-of select="incodev"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="itemloc"/>
  </xsl:template>

  <xsl:template match="dmTitle" mode="xlink">
    <xsl:apply-templates select="techName" mode="xlink"/>
    <xsl:if test="infoName">
      <xsl:text> - </xsl:text>
      <xsl:apply-templates select="infoName" mode="xlink"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="dmtitle" mode="xlink">
    <xsl:apply-templates select="techname" mode="xlink"/>
    <xsl:if test="infoname">
      <xsl:text> - </xsl:text>
      <xsl:apply-templates select="infoname" mode="xlink"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="behavior" mode="xlink">
    <xsl:choose>
      <xsl:when test="@linkShow = 'newPane'">new</xsl:when>
      <xsl:when test="@linkShow = 'embedInContext'">embed</xsl:when>
      <xsl:when test="@linkShow = 'replaceAndReturnToSource'">replace</xsl:when>
      <xsl:when test="@linkShow = 'replaceAndNoReturn'">replace</xsl:when>
      <xsl:otherwise>none</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="pmRef">
    <xsl:copy>
      <xsl:attribute name="xlink:type">simple</xsl:attribute>
      <xsl:attribute name="xlink:href">
        <xsl:apply-templates select="pmRefIdent" mode="xlink"/>
      </xsl:attribute>
      <xsl:attribute name="xlink:title">
        <xsl:apply-templates select="pmRefAddressItems/pmTitle" mode="xlink"/>
      </xsl:attribute>
      <xsl:attribute name="xlink:show">
        <xsl:choose>
          <xsl:when test="behavior">
            <xsl:apply-templates select="behavior" mode="xlink"/>
          </xsl:when>
          <xsl:otherwise>replace</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="refpm">
    <xsl:copy>
      <xsl:attribute name="xlink:type">simple</xsl:attribute>
      <xsl:attribute name="xlink:href">
        <xsl:text>URN:S1000D:PMC-</xsl:text>
        <xsl:apply-templates select="pmc" mode="xlink"/>
      </xsl:attribute>
      <xsl:attribute name="xlink:title">
        <xsl:apply-templates select="pmtitle" mode="xlink"/>
      </xsl:attribute>
      <xsl:attribute name="xlink:show">replace</xsl:attribute>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="pmCode" mode="xlink">
    <xsl:value-of select="@modelIdentCode"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="@pmIssuer"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="@pmNumber"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="@pmVolume"/>
  </xsl:template>

  <xsl:template match="pmc" mode="xlink">
    <xsl:value-of select="modelic"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="pmissuer"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="pmnumber"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="pmvolume"/>
  </xsl:template>

  <xsl:template match="pmRefIdent" mode="xlink">
    <xsl:text>URN:S1000D:</xsl:text>
    <xsl:choose>
      <xsl:when test="identExtension">
        <xsl:text>PME-</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>PMC-</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="identExtension">
      <xsl:apply-templates select="identExtension" mode="xlink"/>
      <xsl:text>-</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="pmCode" mode="xlink"/>
  </xsl:template>

  <xsl:template match="graphic">
    <xsl:copy>
      <xsl:attribute name="xlink:type">simple</xsl:attribute>
      <xsl:attribute name="xlink:href">
        <xsl:text>URN:S1000D:</xsl:text>
        <xsl:value-of select="@infoEntityIdent|@boardno"/>
      </xsl:attribute>
      <xsl:attribute name="xlink:title">
        <xsl:apply-templates select="parent::figure/title" mode="xlink"/>
      </xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="internalRef">
    <xsl:copy>
      <xsl:attribute name="xlink:type">simple</xsl:attribute>
      <xsl:attribute name="xlink:href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="@internalRefId"/>
      </xsl:attribute>
      <xsl:attribute name="xlink:title">
        <xsl:choose>
          <xsl:when test="@targetTitle">
            <xsl:value-of select="@targetTitle"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="."/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="xlink:show">replace</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="catalogSeqNumberRef">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="xlink:type">simple</xsl:attribute>
      <xsl:attribute name="xlink:href">
        <xsl:variable name="dmc" select="ancestor::dmodule//dmIdent/dmCode"/>
        <xsl:variable name="csn">
          <xsl:choose>
            <xsl:when test="@systemCode">
              <xsl:value-of select="@systemCode"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$dmc/@systemCode"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>-</xsl:text>
          <xsl:choose>
            <xsl:when test="@subSystemCode">
              <xsl:value-of select="@subSystemCode"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$dmc/@subSystemCode"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="@subSubSystemCode">
              <xsl:value-of select="@subSubSystemCode"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$dmc/@subSystemCode"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>-</xsl:text>
          <xsl:choose>
            <xsl:when test="@assyCode">
              <xsl:value-of select="@assyCode"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$dmc/@assyCode"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>-</xsl:text>
          <xsl:value-of select="@figureNumber"/>
          <xsl:choose>
            <xsl:when test="@figureNumberVariant">
              <xsl:value-of select="@figureNumberVariant"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>A</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:text>URN:S1000D:DMC-</xsl:text>
        <xsl:choose>
          <xsl:when test="@modelIdentCode">
            <xsl:value-of select="@modelIdentCode"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$dmc/@modelIdentCode"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>-</xsl:text>
        <xsl:choose>
          <xsl:when test="@systemDiffCode">
            <xsl:value-of select="@systemDiffCode"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$dmc/@systemDiffCode"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="$csn"/>
        <xsl:text>-941A-</xsl:text>
        <xsl:choose>
          <xsl:when test="@itemLocationCode">
            <xsl:value-of select="@itemLocationCode"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>D</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>#csn-</xsl:text>
        <xsl:value-of select="$csn"/>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="@item"/>
        <xsl:choose>
          <xsl:when test="@itemVariant">
            <xsl:value-of select="@itemVariant"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>A</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
