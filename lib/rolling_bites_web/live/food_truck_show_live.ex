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
end
