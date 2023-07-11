defmodule RollingBitesWeb.FoodTruckClient do
  @behaviour RollingBitesWeb.FoodTruckClientBehaviour
  use HTTPoison.Base
  require Logger

  alias HTTPoison.Response

  def access_token, do: Application.get_env(:rolling_bites, :soda_api_key)
  def base_url, do: Application.get_env(:rolling_bites, :soda_url)
  def http_client, do: Application.get_env(:rolling_bites, :http_client)

  @spec fetch_all_data :: {:ok, any()} | {:error, any()}
  def fetch_all_data() do
    base_url()
    |> do_get()
  end

  @spec fetch_by_id(String.t() | integer()) :: {:ok, any()} | {:error, any()}
  def fetch_by_id(id) when is_binary(id), do: fetch_by_id(String.to_integer(id))

  def fetch_by_id(id) do
    (base_url() <> "?objectid=#{id}")
    |> do_get()
  end

  defp headers() do
    soda_api_key = Application.get_env(:rolling_bites, :soda_api_key)

    [
      {"X-App-Token", "#{soda_api_key}"}
    ]
  end

  defp handle_response(response) do
    case response do
      {:ok, %Response{status_code: 200, body: body}} ->
        Logger.info("Data retrieval was successful")
        {:ok, Jason.decode!(body)}

      {:ok, %Response{status_code: status, body: body}} ->
        Logger.error("Unexpected status #{status}: #{body}")
        {:error, "Unexpected status #{status}: #{body}"}

      {:error, error} ->
        Logger.error("Failed to fetch data: #{inspect(error)}")
        {:error, "Failed to fetch data: #{inspect(error)}"}
    end
  end

  defp do_get(url) do
    Logger.info("Connecting to SODA API")

    url
    |> http_client().get(headers())
    |> handle_response()
  end
end
