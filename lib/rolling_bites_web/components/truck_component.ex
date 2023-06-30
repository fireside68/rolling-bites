defmodule RollingBites.TruckComponent do
  use Phoenix.Component

  attr :latitude, :string
  attr :longitude, :string
  attr :name, :string
  def map(assigns) do
    ~H"""
    <section id="leaflet-map" class="row" phx-update="ignore">
      <div
        id="map"
        phx-hook="Map"
        data-lat="{@latitude}"
        data-lng="{@longitude}"
        data-name="{@name}"
      >
      </div>
    </section>
    """
  end
end
