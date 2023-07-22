defmodule RollingBitesWeb.MapComponent do
  use RollingBitesWeb, :live_component

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
    """
  end

  def update(_assigns, socket) do
    {:ok, socket}
  end
end
