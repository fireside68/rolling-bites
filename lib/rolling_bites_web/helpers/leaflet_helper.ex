defmodule RollingBitesWeb.LeafletHelper do

  def leaflet_css_tag() do
    """
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
    integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
    crossorigin=""/>
    """
  end

  def leaflet_javascript_tag() do
    """
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
    integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
    crossorigin=""></script>
    """
  end

  def leaflet_javascript(latitude, longitude, name) do
    """
    <script>
      var map = L.map('map').setView([#{latitude}, #{longitude}], 13);

      L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
          attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
      }).addTo(map);

      L.marker([51.5, -0.09]).addTo(map)
        .bindPopup('#{name}')
        .openPopup();
    </script>
    """
  end
end
