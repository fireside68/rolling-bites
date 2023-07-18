import L from "leaflet";

const IndexMap = {
  mounted() {
    window.myMarkers = [];
    window.startingLatitude = parseFloat(this.el.dataset.latitude) || 34.0489;
    window.startingLongitude = parseFloat(this.el.dataset.longitude) || -111.0937;
    this.handleEvent('update_trucks', ({trucks}) => this.updateMarkers(trucks))
  },
  renderMap() {
    console.log("IndexMap is mounted...");
    let trucks = JSON.parse(this.el.dataset.trucks) || [];
    if (!this.map) {
      let latitude = parseFloat(this.el.dataset.latitude) || window.startingLatitude;
      let longitude = parseFloat(this.el.dataset.longitude) || window.startingLongitude;
      this.map = L.map('index-map').setView([latitude, longitude], 6);

      // Add a tile layer to the map
      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors'
      }).addTo(window.myMap);

      L.marker([latitude, longitude]).addTo(this.map)
        .bindPopup('Yay!')
        .openPopup();
    }

    window.myMarkers = [];

    // Add initial markers
    this.updateMarkers(trucks);

  },
  updated() {
    let trucks = JSON.parse(this.el.dataset.trucks) || []
    this.updateMarkers(trucks);
  },
  updateMarkers(trucks) {
    // Get new truck data
    // let trucks = JSON.parse(this.el.dataset.trucks);
    if (trucks === null || trucks == []) {
      return;
    }
    // Initialize window.myMarkers if it's not already defined
    if (!window.myMarkers) {
      window.myMarkers = {};
    }

    if (!window.myMap) {
      window.myMap = L.map('index-map').setView([window.startingLatitude, window.startingLongitude], 6);

      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors'
      }).addTo(window.myMap);
    }
    // Create a set of the new truck ids
    let newTruckIds = new Set(trucks.map(truck => truck.id));

    // Remove markers for trucks that are not in the new data
    for (let id in window.myMarkers) {
      if (!newTruckIds.has(id)) {
        window.myMap.removeLayer(window.myMarkers[id]);
        delete window.myMarkers[id];
      }
    }

    // Update or create markers for each truck
    trucks.forEach(truck => {
      let marker = window.myMarkers[truck.id];
      if (marker) {
        // Update the position and popup of the existing marker
        marker.setLatLng([truck.latitude, truck.longitude]);
        marker.setPopupContent(`<b>${truck.name}</b><br>I am a popup.`);
      } else {
        // Create a new marker and store it in the markers object
        window.myMarkers[truck.id] = L.marker([truck.latitude, truck.longitude])
          .addTo(window.myMap)
          .bindPopup(`<b>${truck.name}</b><br>I am a popup.`);
      }

      let bounds = L.latLngBounds();
      for (let id in window.myMarkers) {
        bounds.extend(window.myMarkers[id].getLatLng());
      }
      window.myMap.fitBounds(bounds);
    });
  }
};

export default IndexMap;
