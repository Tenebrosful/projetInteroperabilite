 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="html" encoding="UTF-8" indent="yes"/>

   <!-- On démarre de la racine -->
   <xsl:template match="/current"> 
     <!-- On parcourt le sous-arbre dans l'ordre 'normal' -->
    <html>
      <head>
        <title>A bicyclette</title>
        <link rel="stylesheet"
          href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" 
          integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
          crossorigin=""/>
          <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
          integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="
          crossorigin=""></script>
      </head>
      <body>
        <h2>Position</h2>
        <ul>
          <xsl:apply-templates select="city" mode="position"/>
        </ul>
        <h2>Météo</h2>
        <ul>
          <xsl:apply-templates select="city" mode="meteo"/>
          <xsl:apply-templates select="temperature"/>
          <xsl:apply-templates select="humidity"/>
          <xsl:apply-templates select="wind"/>
          <xsl:apply-templates select="clouds"/>
          <xsl:apply-templates select="weather"/>
        </ul>
        <h2>Map</h2>
        <div style="height: 300px; width: 400px" id="map">
          <script type="text/javascript">var map = L.map('map').setView([<xsl:apply-templates select="city" mode="positionlat"/>,<xsl:apply-templates select="city" mode="positionlon"/>], 13);
        </script>
        </div>
      </body>
    </html>  

<!-- Template de MEP -->

   </xsl:template>
   
   <xsl:template match="city" mode="position">
    
    <xsl:apply-templates select="@name"/>

   </xsl:template>

   <xsl:template match="city" mode="positionlat">
    
    <xsl:apply-templates select="coord/@lat"/>

   </xsl:template>

   <xsl:template match="city" mode="positionlon">
    
    <xsl:apply-templates select="coord/@lon"/>

   </xsl:template>

   <xsl:template match="city" mode="meteo">
    
    <xsl:apply-templates select="sun"/>

   </xsl:template>

   <xsl:template match="wind">
    
    <xsl:apply-templates select="speed"/> <xsl:apply-templates select="direction"/>

   </xsl:template>

   <xsl:template match="temperature">
    
    <xsl:apply-templates select="@value"/>

   </xsl:template>

   <xsl:template match="humidity">
    
    <xsl:apply-templates select="@value"/>

   </xsl:template>

   <xsl:template match="clouds">
    
    <xsl:apply-templates select="@name"/>

   </xsl:template>

   <xsl:template match="weather">
    
    <xsl:apply-templates select="@value"/>

   </xsl:template>

   <xsl:template match="city/sun">
     <xsl:apply-templates select="@rise"/>
     <xsl:apply-templates select="@set"/>
   </xsl:template>

   <xsl:template match="speed">
     <xsl:apply-templates select="@value"/>
   </xsl:template>

<!-- Template de données -->

   <xsl:template match="city/@name">
     <li>Ville : <xsl:value-of select="."/></li>
   </xsl:template>

   <xsl:template match="sun/@rise">
     <li>Le soleil se lève à : <xsl:value-of select="."/></li>
   </xsl:template> 

   <xsl:template match="sun/@set">
     <li>Le soleil se couche à : <xsl:value-of select="."/></li>
   </xsl:template>

   <xsl:template match="temperature/@value">
     <li>Temperature : <xsl:value-of select="."/> °C</li>
   </xsl:template> 

   <xsl:template match="humidity/@value">
     <li>Humidité : <xsl:value-of select="."/> %</li>
   </xsl:template> 

   <xsl:template match="speed/@value">
     <li>Vent : <xsl:value-of select="."/> m/s</li>
   </xsl:template> 

   <xsl:template match="clouds/@name">
     <li>Ciel : <xsl:value-of select="."/></li>
   </xsl:template> 

   <xsl:template match="weather/@value">
     <li>Précipitation : <xsl:value-of select="."/></li>
   </xsl:template> 

  <xsl:template match="text()"/>

</xsl:stylesheet>
