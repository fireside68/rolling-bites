defmodule RollingBitesWeb.FoodTruckIndexLive do
  use RollingBitesWeb, :live_view

  alias RollingBites.IPFetchServer
  alias RollingBites.SodaAPIServer
  alias RollingBitesWeb.FoodTruckHelper

  def mount(_params, _session, socket) do
    truck_data = SodaAPIServer.get_data()
    %{"latitude" => latitude, "longitude" => longitude} = IPFetchServer.get_user_ip_location()

    {:ok,
     assign(socket,
       items: transform_data_for_index_table(truck_data),
       location: %{latitude: latitude, longitude: longitude},
       truck_data: truck_data,
       trucks: []
     )}
  end

  def handle_event("show_trucks", %{"name" => name}, socket) do
    {:noreply,
     push_redirect(assign(socket, truck_data: socket.assigns.truck_data),
       to: "/trucks/show/#{name}"
     )}
  end

  def handle_event("got_location", %{"latitude" => lat, "longitude" => lon}, socket) do
    location = %{latitude: lat, longitude: lon}

    closest_trucks =
      socket.assigns.truck_data
      |> fetch_closest_trucks(location)

    truck_points = get_truck_points(closest_trucks)
    socket = push_event(socket, "update_trucks", %{trucks: truck_points})

    {:noreply, assign(socket, location: location, trucks: truck_points)}
  end

  def handle_info(:after_mount, socket) do
    if location = socket.assigns[:location] do
      closest_trucks =
        socket.assigns.truck_data
        |> fetch_closest_trucks(location)

      truck_points = get_truck_points(closest_trucks)
      send(self(), {:update_closest_trucks, truck_points})
      {:noreply, assign(socket, trucks: truck_points)}
    else
      # Handle case when the location isn't available yet
      {:noreply, socket}
    end
  end

  def handle_info({:update_closest_trucks, closest_trucks}, socket) do
    IO.puts("Sending trucks to uct event \n\n\n")
    # Send the closest_trucks to the client
    socket = push_event(socket, "update_trucks", %{trucks: closest_trucks})
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <section id="indexMapContainer" phx-hook="GetLocation">
      <div
        id="index-map"
        data-trucks={Jason.encode!(@trucks)}
        data-latitude={@location.latitude}
        data-longitude={@location.longitude}
        phx-hook="IndexMap"
      >
      </div>
    </section>
    <div class="cards-container">
      <%= for item <- @items do %>
        <div class="truck-card" phx-click="show_trucks" phx-value-name={item.name}>
          <div class="truck-icon-container">
            <i class="truck-icon"></i>
          </div>
          <div class="truck-name">
            <%= item.name %>
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  def transform_data_for_index_table(data), do: data |> FoodTruckHelper.group_and_sort_trucks()

  def fetch_closest_trucks(data, user_location) do
    data
    |> Enum.map(fn truck ->
      dist =
        RollingBitesWeb.FoodTruckHelper.haversine_distance(
          {get_float(truck.latitude), get_float(truck.longitude)},
          {get_float(user_location.latitude), get_float(user_location.longitude)}
        )

      {dist, truck}
    end)
    # sort by distance
    |> Enum.sort(fn {dist1, _}, {dist2, _} -> dist1 < dist2 end)
    # take the closest 10 trucks
    |> Enum.take(10)
    # remove the distance, leaving only the trucks
    |> Enum.map(fn {_, truck} -> truck end)
  end

  defp get_float(map_point) when is_float(map_point), do: map_point

  defp get_float(map_point) do
    {point, _} = Float.parse(map_point)
    point
  end

  defp get_truck_points(trucks) do
    Enum.map(trucks, fn truck ->
      %{
        "id" => truck.id,
        "latitude" => truck.latitude,
        "longitude" => truck.longitude,
        "name" => truck.name
      }
    end)
  end
end
