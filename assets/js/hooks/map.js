import L from "leaflet"

const Map = {
  mounted() {
    this.handleEvent('coordinates_update', ({latitude, longitude, name}) => this.renderMap(latitude, longitude, name))
    // Rest of your code...
  },
  updated() {
    this.renderMap(this.el.dataset.lat, this.el.dataset.lng, this.el.dataset.name)
  },
  renderMap(latitude, longitude, name) {
    if (!this.map) {
      this.map = L.map('map').setView([latitude, longitude], 17);

      L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
      }).addTo(this.map);

      L.marker([latitude, longitude]).addTo(this.map)
        .bindPopup(name)
        .openPopup();
    } else {
      this.map.setView([latitude, longitude], 17);
      L.marker([latitude, longitude]).addTo(this.map)
        .bindPopup(name)
        .openPopup();
    }
  }
}
export default Map;
