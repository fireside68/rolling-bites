defmodule RollingBites.SodaAPIServer do
  use GenServer
  use HTTPoison.Base
  require Logger

  alias RollingBitesWeb.FoodTruckPresenter

  # Client

  def start_link(arg) do
    Dotenv.load()
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def get_data do
    GenServer.call(__MODULE__, :get_data)
  end

  # Server

  def init(_arg) do
    Logger.info("Fetching data for user")
    data = fetch_data_and_map_to_presenter()
    Logger.info("Data fetched for user")
    {:ok, %{data: data}}
  end

  def handle_call(:get_data, _from, state) do
    Logger.info("Handling get_data call")
    {:reply, state[:data], state}
  end

  defp fetch_data_and_map_to_presenter do
    {:ok, data} = do_get()
    Enum.map(data, &FoodTruckPresenter.from_api_data/1)
  end

  def base_url, do: Application.get_env(:rolling_bites, :soda_url)
  def http_client, do: Application.get_env(:rolling_bites, :http_client)

  defp headers() do
    soda_api_key = Application.get_env(:rolling_bites, :soda_api_key)

    [
      {"X-App-Token", "#{soda_api_key}"}
    ]
  end

  defp do_get() do
    Logger.info("Connecting to SODA API")

    base_url()
    |> HTTPoison.get(headers())
    |> handle_response()
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Logger.info("Data retrieval was successful")
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: status, body: body}} ->
        Logger.error("Unexpected status #{status}: #{body}")
        {:error, "Unexpected status #{status}: #{body}"}

      {:error, error} ->
        Logger.error("Failed to fetch data: #{inspect(error)}")
        {:error, "Failed to fetch data: #{inspect(error)}"}
    end
  end
end
