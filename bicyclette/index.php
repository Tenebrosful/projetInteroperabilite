<?php

$options = array('http' => array('proxy' =>  'tcp://www-cache:3128','request_fulluri'=> True,));

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

echo str_replace(array("%%lat%%","%%lon%%"), array($latitude,$longitude), $page); 
