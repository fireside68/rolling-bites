defmodule RollingBitesWeb.ApiCallPlugTest do
  use ExUnit.Case
  use Plug.Test
  import Mox

  setup :verify_on_exit!

  setup do
    data =
      "[{\"objectid\":\"1660525\",\"applicant\":\"Natan's Catering\",\"facilitytype\":\"Truck\",\"cnn\":\"1232000\",\"address\":\"435 23RD ST\",\"blocklot\":\"4232010\",\"block\":\"4232\",\"lot\":\"010\",\"permit\":\"22MFF-00073\",\"status\":\"APPROVED\",\"fooditems\":\"Burgers: melts: hot dogs: burritos:sandwiches: fries: onion rings: drinks\",\"x\":\"6016887.317\",\"y\":\"2102871.037\",\"latitude\":\"37.755030726766726\",\"longitude\":\"-122.38453073422282\",\"schedule\":\"http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=22MFF-00073&ExportPDF=1&Filename=22MFF-00073_schedule.pdf\",\"approved\":\"2022-11-18T00:00:00.000\",\"received\":\"20221118\",\"priorpermit\":\"1\",\"expirationdate\":\"2023-11-15T00:00:00.000\",\"location\":{\"latitude\":\"37.755030726766726\",\"longitude\":\"-122.38453073422282\",\"human_address\":\"{\\\"address\\\": \\\"\\\", \\\"city\\\": \\\"\\\", \\\"state\\\": \\\"\\\", \\\"zip\\\": \\\"\\\"}\"},\":@computed_region_yftq_j783\":\"10\",\":@computed_region_p5aj_wyqh\":\"3\",\":@computed_region_rxqg_mtj9\":\"8\",\":@computed_region_bh8s_q3mv\":\"28856\",\":@computed_region_fyvs_ahh9\":\"29\"}\n,{\"objectid\":\"735318\",\"applicant\":\"Ziaurehman Amini\",\"facilitytype\":\"Push Cart\",\"cnn\":\"30727000\",\"locationdescription\":\"MARKET ST: DRUMM ST intersection\",\"address\":\"5 THE EMBARCADERO\",\"blocklot\":\"0234017\",\"block\":\"0234\",\"lot\":\"017\",\"permit\":\"15MFF-0159\",\"status\":\"REQUESTED\",\"x\":\"6013916.72\",\"y\":\"2117244.027\",\"latitude\":\"37.794331003246846\",\"longitude\":\"-122.39581105302317\",\"schedule\":\"http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=15MFF-0159&ExportPDF=1&Filename=15MFF-0159_schedule.pdf\",\"received\":\"20151231\",\"priorpermit\":\"0\",\"expirationdate\":\"2016-03-15T00:00:00.000\",\"location\":{\"latitude\":\"37.794331003246846\",\"longitude\":\"-122.39581105302317\",\"human_address\":\"{\\\"address\\\": \\\"\\\", \\\"city\\\": \\\"\\\", \\\"state\\\": \\\"\\\", \\\"zip\\\": \\\"\\\"}\"},\":@computed_region_yftq_j783\":\"4\",\":@computed_region_p5aj_wyqh\":\"1\",\":@computed_region_rxqg_mtj9\":\"10\",\":@computed_region_bh8s_q3mv\":\"28855\",\":@computed_region_fyvs_ahh9\":\"6\"}]"

    %{data: data}
  end

  alias RollingBitesWeb.FoodTruckPresenter
  alias RollingBitesWeb.ApiCallPlug
  alias RollingBitesWeb.HTTPClientMock

  @opts ApiCallPlug.init([])

  defp response(body, status \\ 200) do
    {:ok, %HTTPoison.Response{status_code: status, body: body}}
  end

  describe "call/2" do
    test "calls the API and assigns data if trucks key not present", %{data: data} do
      expected_response(data)

      conn = conn(:get, "/")
      assert %{assigns: %{trucks: _}} = ApiCallPlug.call(conn, @opts)
    end

    test "calls the API and assigns the data if the :trucks key is present but empty", %{
      data: data
    } do
      expected_response(data)

      conn = conn(:get, "/")
      conn = assign(conn, :trucks, [])

      assert %{assigns: %{trucks: _}} = ApiCallPlug.call(conn, @opts)
    end

    test "doesn't call the API if the trucks key is present and non-empty", %{data: data} do
      trucks =
        Jason.decode!(data)
        |> Enum.map(&FoodTruckPresenter.from_api_data/1)

      conn =
        conn(:get, "/")
        |> assign(:trucks, trucks)

      assert %{assigns: %{trucks: ^trucks}} = ApiCallPlug.call(conn, @opts)
    end
  end

  defp expected_response(data) do
    HTTPClientMock
    |> expect(:get, fn _url, _headers -> response(data) end)
  end
end
