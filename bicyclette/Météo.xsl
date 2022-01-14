 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="html" encoding="UTF-8" indent="yes"/>

   <!-- On démarre de la racine -->
   <xsl:template match="/current"> 
     <!-- On parcourt le sous-arbre dans l'ordre 'normal' -->
    <html>
      <head>
        <title>A bicyclette</title>
        <link rel="stylesheet" href="css/leaflet.extra-markers.min.css"/>
        <link rel="stylesheet" type="text/css" href="css/style.css"/>
        <link rel="stylesheet"
          href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" 
          integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
          crossorigin=""/>
          <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/1.5.2/css/ionicons.min.css"/>
            <link rel="stylesheet" href="css/leaflet.awesome-markers.css"/>
          <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
          integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="
          crossorigin=""></script>
          <script src="js/leaflet.awesome-markers.js"></script>
          <script src="js/leaflet.extra-markers.min.js"></script>
      </head>
      <body>
      <div id="flex-container">
        <div style="height: 100%; width: 60%" id="map">
          <script type="text/javascript">
            var map = L.map('map').setView([%%lat%%,%%lon%%], 13);
        </script>
        <script src="js/script.js"></script>
        <script type="text/javascript">
          L.marker([%%lat%%,%%lon%%], {icon: UserMarker}).addTo(map);
          %%station%%
        </script>
        </div>
        <div id="donnees">
        <table id="data">
          <tr>
            <td id="ville" colspan="2"><xsl:apply-templates select="city" mode="position"/></td>
          </tr>
          <xsl:apply-templates select="temperature"/>
          <xsl:apply-templates select="humidity"/>
          <xsl:apply-templates select="wind"/>
          <xsl:apply-templates select="clouds"/>
          <xsl:apply-templates select="weather"/>
        </table>
      </div>
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
     <xsl:value-of select="."/>
   </xsl:template>

   <xsl:template match="sun/@rise">
     <tr><td>Le soleil se lève à : </td><td><xsl:value-of select="."/></td></tr>
   </xsl:template> 

   <xsl:template match="sun/@set">
     <tr><td>Le soleil se couche à : </td><td><xsl:value-of select="."/></td></tr>
   </xsl:template>

   <xsl:template match="temperature/@value">
     <tr><td>Temperature : </td><td><xsl:value-of select="."/> °C</td></tr>
   </xsl:template> 

   <xsl:template match="humidity/@value">
     <tr><td>Humidité : </td><td><xsl:value-of select="."/> %</td></tr>
   </xsl:template> 

   <xsl:template match="speed/@value">
     <tr><td>Vent : </td><td><xsl:value-of select="."/> m/s</td></tr>
   </xsl:template> 

   <xsl:template match="clouds/@name">
     <tr><td>Ciel : </td><td><xsl:value-of select="."/></td></tr>
   </xsl:template> 

   <xsl:template match="weather/@value">
     <tr><td>Précipitation : </td><td><xsl:value-of select="."/></td></tr>
   </xsl:template> 

  <xsl:template match="text()"/>

</xsl:stylesheet>
