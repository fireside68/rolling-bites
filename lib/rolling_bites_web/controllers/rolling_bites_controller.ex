defmodule RollingBitesWeb.RollingBitesController do
  use RollingBitesWeb, :controller

  alias RollingBitesWeb.FoodTruckClient
  alias RollingBitesWeb.FoodTruckPresenter

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, params) do
    {:ok, data} = FoodTruckClient.fetch_by_id(params["id"])

    truck =
      List.first(data)
      |> FoodTruckPresenter.from_api_data()

    render(conn, "show.html", truck: truck)
  end
end
