import L from "leaflet"

const Map = {
  mounted() {
    var latitude = this.el.dataset.lat;
    var longitude = this.el.dataset.lng;
    var name = this.el.dataset.name;

    var map = L.map('map').setView([latitude, longitude], 17);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    L.marker([latitude, longitude]).addTo(map)
      .bindPopup(name)
      .openPopup();
  },
  updated() {
    this.map.invalidateSize();
  }
}
export default Map;