defmodule RollingBitesWeb.Components.TruckComponent do
  use Phoenix.Component

  attr :latitude, :string
  attr :longitude, :string
  attr :name, :string
  def map(assigns) do
    ~H"""
    <section id="leaflet-map" class="row">
      <div
        id="map"
        phx-hook="Map"
        data-lat={@assigns.latitude}
        data-lng={@assigns.longitude}
        data-name="{@name}"
      >
      </div>
    </section>
    """
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end
end
