<?php

$options = array(
	'http' => array('method' => 'POST','proxy' =>  'tcp://www-cache:3128','request_fulluri'=> True,),
    'ssl' => array(
        'verify_peer'      => false,
        'verify_peer_name' => false,
    ));

$context = stream_context_set_default($options);

//Récupération de la position

$GPSData = file_get_contents("http://ip-api.com/xml/".$_SERVER['REMOTE_ADDR']);

$GPSData = json_decode(json_encode(simplexml_load_string($GPSData)),true);

$latitude = $GPSData['lat'];
$longitude = $GPSData['lon'];

//Récupération des données météorologique

$apiKey = "45f5f752c0d9d62ff8054e3106fefe6d";

$options = "&units=metric&lang=FR&mode=xml";

$data = file_get_contents("https://api.openweathermap.org/data/2.5/weather?lat=".$latitude."&lon=".$longitude."&APPID=".$apiKey.$options);

$xml = new DOMDocument;
$xml->loadXML($data);

$xsl = new DOMDocument;
$xsl->load("Météo.xsl");

$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl);

$page = $proc->transformToXML($xml);

//Récupération position station

$StationData =simplexml_load_string(file_get_contents("http://www.velostanlib.fr/service/carto"));

$stationList = "";

foreach ($StationData->markers->marker as $data)
{
	$stationList .= "L.marker([".$data["lat"].",".$data["lng"]."], {icon: StationMarker}).addTo(map);";

	$DispoData = simplexml_load_string(file_get_contents("http://www.velostanlib.fr/service/stationdetails/nancy/".$data["number"]));

	$stationList .= "L.marker([".$data["lat"].",".$data["lng"]."], {icon:
		L.ExtraMarkers.icon({icon: 'fa-number',number: ".$DispoData->available.",markerColor: 'blue'})
	}).addTo(map);";

}

//Creation de la page

echo str_replace(array("%%lat%%","%%lon%%","%%station%%"), array($latitude,$longitude,$stationList), $page); 
