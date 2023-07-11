defmodule RollingBitesWeb.RollingBitesController do
  use RollingBitesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(%{assigns: %{trucks: trucks}} = conn, params) do
    truck_name = params["name"]
    truck = Enum.find(trucks, fn map -> %{name: ^truck_name} = map end)
    render(conn, "show.html", name: truck.name, entities: truck.entities)
  end
end
