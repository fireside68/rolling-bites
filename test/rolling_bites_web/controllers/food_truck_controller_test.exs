defmodule RollingBitesWeb.FoodTruckControllerTest do
  use RollingBitesWeb.ConnCase

  import RollingBites.FoodTrucksFixtures

  alias RollingBites.FoodTrucks.FoodTruck

  @create_attrs %{
    block: "some block",
    status: "some status",
    address: "some address",
    permit: "some permit",
    location: "some location",
    approved: "some approved",
    y: "some y",
    x: "some x",
    location_id: "some location_id",
    facility_type: "some facility_type",
    location_description: "some location_description",
    blocklot: "some blocklot",
    lot: "some lot",
    food_items: "some food_items",
    latitude: "some latitude",
    longitude: "some longitude",
    schedule: "some schedule",
    days_hours: "some days_hours",
    noi_sent: "some noi_sent",
    received: "some received",
    prior_permit: "some prior_permit",
    expiration_date: "some expiration_date",
    fire_prevention_districts: "some fire_prevention_districts",
    police_districts: "some police_districts",
    supervisor_districts: "some supervisor_districts",
    zip_codes: "some zip_codes",
    neighborhoods: "some neighborhoods"
  }
  @update_attrs %{
    block: "some updated block",
    status: "some updated status",
    address: "some updated address",
    permit: "some updated permit",
    location: "some updated location",
    approved: "some updated approved",
    y: "some updated y",
    x: "some updated x",
    location_id: "some updated location_id",
    facility_type: "some updated facility_type",
    location_description: "some updated location_description",
    blocklot: "some updated blocklot",
    lot: "some updated lot",
    food_items: "some updated food_items",
    latitude: "some updated latitude",
    longitude: "some updated longitude",
    schedule: "some updated schedule",
    days_hours: "some updated days_hours",
    noi_sent: "some updated noi_sent",
    received: "some updated received",
    prior_permit: "some updated prior_permit",
    expiration_date: "some updated expiration_date",
    fire_prevention_districts: "some updated fire_prevention_districts",
    police_districts: "some updated police_districts",
    supervisor_districts: "some updated supervisor_districts",
    zip_codes: "some updated zip_codes",
    neighborhoods: "some updated neighborhoods"
  }
  @invalid_attrs %{
    block: nil,
    status: nil,
    address: nil,
    permit: nil,
    location: nil,
    approved: nil,
    y: nil,
    x: nil,
    location_id: nil,
    facility_type: nil,
    location_description: nil,
    blocklot: nil,
    lot: nil,
    food_items: nil,
    latitude: nil,
    longitude: nil,
    schedule: nil,
    days_hours: nil,
    noi_sent: nil,
    received: nil,
    prior_permit: nil,
    expiration_date: nil,
    fire_prevention_districts: nil,
    police_districts: nil,
    supervisor_districts: nil,
    zip_codes: nil,
    neighborhoods: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all food-trucks", %{conn: conn} do
      conn = get(conn, ~p"/api/food-trucks")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create food_truck" do
    test "renders food_truck when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/food-trucks", food_truck: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/food-trucks/#{id}")

      assert %{
               "id" => ^id,
               "address" => "some address",
               "approved" => "some approved",
               "block" => "some block",
               "blocklot" => "some blocklot",
               "days_hours" => "some days_hours",
               "expiration_date" => "some expiration_date",
               "facility_type" => "some facility_type",
               "fire_prevention_districts" => "some fire_prevention_districts",
               "food_items" => "some food_items",
               "latitude" => "some latitude",
               "location" => "some location",
               "location_description" => "some location_description",
               "location_id" => "some location_id",
               "longitude" => "some longitude",
               "lot" => "some lot",
               "neighborhoods" => "some neighborhoods",
               "noi_sent" => "some noi_sent",
               "permit" => "some permit",
               "police_districts" => "some police_districts",
               "prior_permit" => "some prior_permit",
               "received" => "some received",
               "schedule" => "some schedule",
               "status" => "some status",
               "supervisor_districts" => "some supervisor_districts",
               "x" => "some x",
               "y" => "some y",
               "zip_codes" => "some zip_codes"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/food-trucks", food_truck: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update food_truck" do
    setup [:create_food_truck]

    test "renders food_truck when data is valid", %{
      conn: conn,
      food_truck: %FoodTruck{id: id} = food_truck
    } do
      conn = put(conn, ~p"/api/food-trucks/#{food_truck}", food_truck: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/food-trucks/#{id}")

      assert %{
               "id" => ^id,
               "address" => "some updated address",
               "approved" => "some updated approved",
               "block" => "some updated block",
               "blocklot" => "some updated blocklot",
               "days_hours" => "some updated days_hours",
               "expiration_date" => "some updated expiration_date",
               "facility_type" => "some updated facility_type",
               "fire_prevention_districts" => "some updated fire_prevention_districts",
               "food_items" => "some updated food_items",
               "latitude" => "some updated latitude",
               "location" => "some updated location",
               "location_description" => "some updated location_description",
               "location_id" => "some updated location_id",
               "longitude" => "some updated longitude",
               "lot" => "some updated lot",
               "neighborhoods" => "some updated neighborhoods",
               "noi_sent" => "some updated noi_sent",
               "permit" => "some updated permit",
               "police_districts" => "some updated police_districts",
               "prior_permit" => "some updated prior_permit",
               "received" => "some updated received",
               "schedule" => "some updated schedule",
               "status" => "some updated status",
               "supervisor_districts" => "some updated supervisor_districts",
               "x" => "some updated x",
               "y" => "some updated y",
               "zip_codes" => "some updated zip_codes"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, food_truck: food_truck} do
      conn = put(conn, ~p"/api/food-trucks/#{food_truck}", food_truck: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete food_truck" do
    setup [:create_food_truck]

    test "deletes chosen food_truck", %{conn: conn, food_truck: food_truck} do
      conn = delete(conn, ~p"/api/food-trucks/#{food_truck}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/food-trucks/#{food_truck}")
      end
    end
  end

  defp create_food_truck(_) do
    food_truck = food_truck_fixture()
    %{food_truck: food_truck}
  end
end
