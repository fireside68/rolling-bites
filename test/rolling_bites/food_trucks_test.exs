defmodule RollingBites.FoodTrucksTest do
  use RollingBites.DataCase

  alias RollingBites.FoodTrucks

  describe "food_trucks" do
    alias RollingBites.FoodTrucks.FoodTruck

    import RollingBites.FoodTrucksFixtures

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

    test "list_food_trucks/0 returns all food_trucks" do
      food_truck = food_truck_fixture()
      assert FoodTrucks.list_food_trucks() == [food_truck]
    end

    test "get_food_truck!/1 returns the food_truck with given id" do
      food_truck = food_truck_fixture()
      assert FoodTrucks.get_food_truck!(food_truck.id) == food_truck
    end

    test "create_food_truck/1 with valid data creates a food_truck" do
      valid_attrs = %{
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

      assert {:ok, %FoodTruck{} = food_truck} = FoodTrucks.create_food_truck(valid_attrs)
      assert food_truck.block == "some block"
      assert food_truck.status == "some status"
      assert food_truck.address == "some address"
      assert food_truck.permit == "some permit"
      assert food_truck.location == "some location"
      assert food_truck.approved == "some approved"
      assert food_truck.y == "some y"
      assert food_truck.x == "some x"
      assert food_truck.location_id == "some location_id"
      assert food_truck.facility_type == "some facility_type"
      assert food_truck.location_description == "some location_description"
      assert food_truck.blocklot == "some blocklot"
      assert food_truck.lot == "some lot"
      assert food_truck.food_items == "some food_items"
      assert food_truck.latitude == "some latitude"
      assert food_truck.longitude == "some longitude"
      assert food_truck.schedule == "some schedule"
      assert food_truck.days_hours == "some days_hours"
      assert food_truck.noi_sent == "some noi_sent"
      assert food_truck.received == "some received"
      assert food_truck.prior_permit == "some prior_permit"
      assert food_truck.expiration_date == "some expiration_date"
      assert food_truck.fire_prevention_districts == "some fire_prevention_districts"
      assert food_truck.police_districts == "some police_districts"
      assert food_truck.supervisor_districts == "some supervisor_districts"
      assert food_truck.zip_codes == "some zip_codes"
      assert food_truck.neighborhoods == "some neighborhoods"
    end

    test "create_food_truck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FoodTrucks.create_food_truck(@invalid_attrs)
    end

    test "update_food_truck/2 with valid data updates the food_truck" do
      food_truck = food_truck_fixture()

      update_attrs = %{
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

      assert {:ok, %FoodTruck{} = food_truck} =
               FoodTrucks.update_food_truck(food_truck, update_attrs)

      assert food_truck.block == "some updated block"
      assert food_truck.status == "some updated status"
      assert food_truck.address == "some updated address"
      assert food_truck.permit == "some updated permit"
      assert food_truck.location == "some updated location"
      assert food_truck.approved == "some updated approved"
      assert food_truck.y == "some updated y"
      assert food_truck.x == "some updated x"
      assert food_truck.location_id == "some updated location_id"
      assert food_truck.facility_type == "some updated facility_type"
      assert food_truck.location_description == "some updated location_description"
      assert food_truck.blocklot == "some updated blocklot"
      assert food_truck.lot == "some updated lot"
      assert food_truck.food_items == "some updated food_items"
      assert food_truck.latitude == "some updated latitude"
      assert food_truck.longitude == "some updated longitude"
      assert food_truck.schedule == "some updated schedule"
      assert food_truck.days_hours == "some updated days_hours"
      assert food_truck.noi_sent == "some updated noi_sent"
      assert food_truck.received == "some updated received"
      assert food_truck.prior_permit == "some updated prior_permit"
      assert food_truck.expiration_date == "some updated expiration_date"
      assert food_truck.fire_prevention_districts == "some updated fire_prevention_districts"
      assert food_truck.police_districts == "some updated police_districts"
      assert food_truck.supervisor_districts == "some updated supervisor_districts"
      assert food_truck.zip_codes == "some updated zip_codes"
      assert food_truck.neighborhoods == "some updated neighborhoods"
    end

    test "update_food_truck/2 with invalid data returns error changeset" do
      food_truck = food_truck_fixture()

      assert {:error, %Ecto.Changeset{}} =
               FoodTrucks.update_food_truck(food_truck, @invalid_attrs)

      assert food_truck == FoodTrucks.get_food_truck!(food_truck.id)
    end

    test "delete_food_truck/1 deletes the food_truck" do
      food_truck = food_truck_fixture()
      assert {:ok, %FoodTruck{}} = FoodTrucks.delete_food_truck(food_truck)
      assert_raise Ecto.NoResultsError, fn -> FoodTrucks.get_food_truck!(food_truck.id) end
    end

    test "change_food_truck/1 returns a food_truck changeset" do
      food_truck = food_truck_fixture()
      assert %Ecto.Changeset{} = FoodTrucks.change_food_truck(food_truck)
    end
  end
end
