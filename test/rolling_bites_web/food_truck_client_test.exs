defmodule RollingBites.FoodTruckClientTest do
  use ExUnit.Case
  import Mox
  alias RollingBitesWeb.FoodTruckClient
  alias RollingBitesWeb.HTTPClientMock

  # Ensure that the mock acts as the HttpClient
  setup :verify_on_exit!

  defp response(body, status \\ 200) do
    {:ok, %HTTPoison.Response{status_code: status, body: body}}
  end

  test "fetch_all_data/0 with successful response" do
    HTTPClientMock
    |> expect(:get, fn _url, _headers -> response(~s({"key": "value"})) end)

    assert {:ok, %{"key" => "value"}} = FoodTruckClient.fetch_all_data()
  end

  test "fetch_all_data/0 with error response" do
    HTTPClientMock
    |> expect(:get, fn _url, _headers -> response("error", 400) end)

    assert {:error, _} = FoodTruckClient.fetch_all_data()
  end

  test "fetch_all_data/0 with failed request" do
    HTTPClientMock
    |> expect(:get, fn _url, _headers -> {:error, :failed} end)

    assert {:error, _} = FoodTruckClient.fetch_all_data()
  end

  describe "fetch_by_id/1" do
    test "fetch_by_id/1 with successful response" do
      HTTPClientMock
      |> expect(:get, fn _url, _headers -> response(~s({"key": "value"})) end)

      assert {:ok, %{"key" => "value"}} = FoodTruckClient.fetch_by_id("1")
    end

    test "fetch_by_id/1 with error response" do
      HTTPClientMock
      |> expect(:get, fn _url, _headers -> response("error", 400) end)

      assert {:error, _} = FoodTruckClient.fetch_by_id("2")
    end

    test "fetch_by_id/1 with failed request" do
      HTTPClientMock
      |> expect(:get, fn _url, _headers -> {:error, :failed} end)

      assert {:error, _} = FoodTruckClient.fetch_by_id("3")
    end
  end
end
