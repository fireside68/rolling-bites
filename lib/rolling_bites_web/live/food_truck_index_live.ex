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

  # Fetches the truck data from the API
  def fetch_items do
    {:ok, data} = FoodTruckClient.fetch_all_data()

    Enum.map(data, &FoodTruckPresenter.from_api_data/1)
    |> FoodTruckHelper.group_and_sort_trucks()
  end
end
