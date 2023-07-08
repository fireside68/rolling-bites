defmodule RollingBitesWeb.FoodTruckDetailLive do
  use RollingBitesWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, current_coordinates: %{latitude: "37.7598", longitude: "-122.4271"})}
  end
  def handle_event("show-on-map", %{"latitude" => latitude, "longitude" => longitude}, socket) do
    {:noreply, assign(socket, :current_coordinates, %{latitude: latitude, longitude: longitude})}
  end

  def render(assigns) do
    ~H"""
      <section id="leaflet-map" class="row" phx-update="ignore">
        <div
          id="map"
          phx-hook="Map"
          data-lat={@truck.latitude}
          data-lng={@truck.longitude}
          data-name={@truck.name}
          style="height: 500px;"
        >
        </div>
      </section>
      <div class="food-truck my-16">
        <h2 class="lg:text-5xl md:text-5xl sm:text-3xl"><%= @truck.name %></h2>
        <p class="text-lg"><%= @truck.address %></p>
        <p><%= @truck.description %></p>
        <.link navigate={@truck.schedule_url}>Schedule</.link>
      </div>
    """
  end
end
