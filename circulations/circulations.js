/**
 * @var axios
 */

// @ts-ignore
const mymap = L.map('mapid').setView([47.3803867, -1.7113826], 10);

// @ts-ignore
L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw',
    {
        maxZoom: 20,
        attribution: 'Map data: <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors,' +
            'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>' +
            '<a href="https://icons8.com/icon/113531/musée">Musée icon by Icons8</a>',
        id: 'mapbox/streets-v11',
        tileSize: 512,
        zoomOffset: -1
    }).addTo(mymap);

const mairieIcon = L.icon({iconUrl: "https://img.icons8.com/bubbles/50/000000/museum.png", iconSize: [40,40]});

L.marker([47.3803867, -1.7113826], {title: "Mairie de Notre-Dame-des-Landes", alt: "Position sur la carte de la Mairie de Notre-Dame-des-Landes", icon: mairieIcon}).addTo(mymap)
    .bindPopup("Mairie de Notre-Dame-des-Landes");