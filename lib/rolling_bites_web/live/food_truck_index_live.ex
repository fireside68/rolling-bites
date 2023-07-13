defmodule RollingBitesWeb.FoodTruckIndexLive do
  use RollingBitesWeb, :live_view

  alias RollingBitesWeb.FoodTruckClient
  alias RollingBitesWeb.FoodTruckHelper
  alias RollingBitesWeb.FoodTruckPresenter

  def mount(_params, _session, socket) do
    {:ok, assign(socket, items: fetch_items())}
  end

  def handle_event("show_trucks", %{"name" => name}, socket) do
    {:noreply, push_redirect(socket, to: "/trucks/show/#{name}")}
  end


  def handle_info(:after_mount, socket) do
    case fetch_user_location() do
      {:ok, location} ->
        closest_trucks = fetch_closest_trucks(location)
        {:noreply, assign(socket, items: closest_trucks)}

      {:error, reason} ->
        # Handle error, e.g., show an error message on the page
        {:noreply, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <table>
      <thead>
        <tr>
          <th>Name</th>
        </tr>
      </thead>
      <tbody>
        <%= for item <- @items do %>
          <tr phx-click="show_trucks" phx-value-name={item.name}>
            <td><%= item.name %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end

  defp fetch_user_location do
    # Logic to fetch the user's location
    case GeoIP2.lookup_user_location() do
      {:ok, location} ->
        {:ok, location}

      {:error, reason} ->
        {:error, reason}
    end
  end

  # Fetches the truck data from the API
  def fetch_items do
    {:ok, data} = FoodTruckClient.fetch_all_data()

    Enum.map(data, &FoodTruckPresenter.from_api_data/1)
    |> FoodTruckHelper.group_and_sort_trucks()
  end
end
