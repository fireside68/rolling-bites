defmodule RollingBitesWeb.ApiCallPlug do
  @moduledoc """
    Plug responsible for determining whether the :trucks key on the conn's
    assigns contains the necessary data. If the key is not present, or if
    it is present and empty, the plug calls the API to gather the necessary
    data. If the key is present and properly filled, the conn passes through
    untouched.
  """
  require Logger

  @behaviour Plug

  alias Plug.Conn
  alias RollingBitesWeb.FoodTruckClient
  alias RollingBitesWeb.FoodTruckPresenter

  @spec init(Keyword.t()) ::Keyword.t()
  def init(opts), do: opts

  @spec call(Conn.t(), Keyword.t()) :: Conn.t()
  def call(%{assigns: %{trucks: trucks}} = conn, _opts) do
    Logger.info("Checking trucks data...")
    case trucks do
      nil -> call_api_and_assign_data(conn)
      [] -> call_api_and_assign_data(conn)
      _ ->
        Logger.info("Datat all good!")
        conn
    end
  end

  def call(conn, _opts), do: call_api_and_assign_data(conn)

  @spec call_api_and_assign_data(Conn.t()) :: Conn.t()
  defp call_api_and_assign_data(conn) do
    {:ok, data} = FoodTruckClient.fetch_all_data()
    trucks = Enum.map(data, &FoodTruckPresenter.from_api_data/1)

    conn
    |> Conn.assign(:trucks, trucks)
  end
end
