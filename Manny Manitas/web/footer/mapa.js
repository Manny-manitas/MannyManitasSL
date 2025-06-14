var map = L.map('map').setView([40.7128, -74.0060], 13); 

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);

L.marker([40.7128, -74.0060]).addTo(map) 
    .bindPopup('¡Aquí estamos!')
    .openPopup();

    document.addEventListener('DOMContentLoaded', function() {
        map.invalidateSize();
    });