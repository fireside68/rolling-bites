defmodule RollingBitesWeb.FoodTruckShowLive do
  use RollingBitesWeb, :live_view

  alias RollingBites.SodaAPIServer
  alias RollingBitesWeb.FoodTruckHelper

  def mount(%{"name" => name} = _params, _session, socket) do
    item =
      SodaAPIServer.get_data()
      |> FoodTruckHelper.group_and_sort_trucks()
      |> Enum.find(fn list_item ->
        list_item.name == URI.decode(name)
      end)

    socket =
      socket
      |> assign(
        current_item: item,
        current_item_name: item.name,
        current_item_entities: item.entities,
        map_stuff: %{latitude: "37.7598", longitude: "-122.4271", name: "Dolores Park"}
      )
      |> push_event("coordinates_update", %{
        latitude: "37.7598",
        longitude: "-122.4271",
        name: "Dolores Park"
      })

    {:ok, socket}
  end

  def handle_event(
        "show-on-map",
        %{
          "latitude" => latitude,
          "longitude" => longitude,
          "name" => name
        } = _params,
        socket
      ) do
    socket =
      socket
      |> assign(map_stuff: %{latitude: latitude, longitude: longitude, name: name})
      |> push_event("coordinates_update", %{latitude: latitude, longitude: longitude, name: name})

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div id="header">
      <h1 class="text-5xl text-center m-16"><%= @map_stuff.name %></h1>
    </div>
    <section class="my-8">
      <h4>
        Map opens to Dolores Park. Click any of the listed food truck locations to render its map point.
      </h4>
    </section>
    <section id="leaflet-map" class="row" phx-update="ignore">
      <div
        id="map"
        phx-hook="Map"
        data-lat={@map_stuff.latitude}
        data-lng={@map_stuff.longitude}
        data-name={@map_stuff.name}
      >
      </div>
    </section>
    <table class="table-auto mt-20">
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Address</th>
          <!-- add other columns as needed -->
        </tr>
      </thead>
      <tbody>
        <%= for entity <- @current_item.entities do %>
          <tr
            phx-click="show-on-map"
            phx-value-latitude={entity.latitude}
            phx-value-longitude={entity.longitude}
            phx-value-name={entity.name}
          >
            <td><%= entity.id %></td>
            <td><%= entity.name %></td>
            <td><%= entity.address %></td>
            <!-- add other columns as needed -->
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end
end
