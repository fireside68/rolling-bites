defmodule RollingBites.IPFetchServer do
  use GenServer
  require Logger

  def start_link(opts \\ []) do
    Dotenv.load()
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def get_user_ip_location do
    GenServer.call(__MODULE__, :get_user_ip_geolocation)
  end

  def init(_opts) do
    ip_geolocation = fetch_user_ip_geolocation()
    {:ok, %{ip_geolocation: ip_geolocation}}
  end

  def handle_call(:get_user_ip_geolocation, _from, state) do
    Logger.info("Handling get_user_ip_geolocation call...")
    {:reply, state[:ip_geolocation], state}
  end

  defp fetch_user_ip_geolocation() do
    api_key = System.get_env("IPGEOLOCATION_API_KEY")

    # Make an HTTP request to IPGeolocation API to fetch the user's IP geolocation
    {:ok, response} =
      HTTPoison.get("https://api.ipgeolocation.io/ipgeo?apiKey=#{api_key}&fields=geo")

    body = response.body

    # Extract the IP geolocation details from the API response (assuming the response is in JSON format)
    ip_geolocation = Jason.decode!(body)

    ip_geolocation
  end
end
