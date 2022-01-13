L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw',
    {
        maxZoom: 20,
        attribution: 'Map data: <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors,' +
            'Imagery ©️ <a href="https://www.mapbox.com/">Mapbox</a>' +
            '<a href="https://icons8.com/icon/113531/musée">Musée icon by Icons8</a>',
        id: 'mapbox/streets-v11',
        tileSize: 512,
        zoomOffset: -1
    }).addTo(map);

