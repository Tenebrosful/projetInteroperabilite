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

axios.get("https://data.loire-atlantique.fr/api/records/1.0/search/?dataset=224400028_info-route-departementale&q=&facet=nature&facet=type&facet=datepublication")
.then((res) => {
    res.data.records.forEach(incident => {
        console.log("New incident", incident)
        const title = getIncidentTitle(incident);
        L.marker([incident.geometry.coordinates[1], incident.geometry.coordinates[0]], {title: title, alt: "Position sur la carte de l'incident: " + title }).addTo(mymap)
            .bindPopup(getIncidentPopup(incident));
    });
});

function getIncidentTitle(incident) {
    return `${incident.fields.ligne1} (${incident.fields.ligne2} ${incident.fields.ligne4})`;
}

function getIncidentPopup(incident) {
    return `<center>${incident.fields.nature}<br/>
    ${incident.fields.ligne1} (${incident.fields.type})<br/>
    ${incident.fields.ligne2}<br/>
    ${incident.fields.ligne4}<br/>
    </center>`
}