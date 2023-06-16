defmodule RollingBites.Seeds do
  @moduledoc """
  Utility module to ingest Mobile_Food_Facility_Permit.csv
  """
  require Logger

  alias NimbleCSV.RFC4180, as: CSV
  alias RollingBites.FoodTrucks
  alias RollingBites.FoodTrucks.FoodTruck

  def import_food_truck_data do
    file_path = Path.expand("priv/static/Mobile_Food_Facility_Permit.csv")

    Logger.info("Starting data import from CSV...")

    column_names = get_column_names(file_path)

    file_path
    |> File.stream!
    |> CSV.parse_stream(skip_headers: true)
    |> Enum.each(fn row ->
      row
      |> Enum.with_index()
      |> Map.new(fn {val, num} -> {column_names[num], val} end)
      |> transform_to_food_truck()
      |> create_food_truck()
    end)

    Logger.info("Process to read and import CSV complete")
  end

  defp get_column_names(file) do
    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: false)
    |> Enum.fetch!(0)
    |> Enum.with_index()
    |> Map.new(fn {val, num} -> {num, val} end)
  end

  defp transform_to_food_truck(row) do
    %{
      block: row["block"],
      status: row["Status"],
      address: row["Address"],
      permit: row["permit"],
      location: row["Location"],
      approved: row["Approved"],
      y: row["Y"],
      x: row["X"],
      location_id: row["locationid"],
      facility_type: row["FacilityType"],
      location_description: row["LocationDescription"],
      blocklot: row["blocklot"],
      lot: row["lot"],
      food_items: row["FoodItems"],
      latitude: row["Latitude"],
      longitude: row["Longitude"],
      schedule: row["Schedule"],
      days_hours: row["dayshours"],
      noi_sent: row["NOISent"],
      received: row["Received"],
      prior_permit: row["PriorPermit"],
      expiration_date: row["ExpirationDate"],
      fire_prevention_districts: row["Fire Prevention Districts"],
      police_districts: row["Police Districts"],
      supervisor_districts: row["Supervisor Districts"],
      zip_codes: row["Zip Codes"],
      neighborhoods: row["Neighborhoods (old)"]
    }
  end

  defp create_food_truck(food_truck) do
    case FoodTrucks.create_food_truck(food_truck) do
      {:ok, %FoodTruck{}} ->
        Logger.info("Food truck saved to database successfully.")

      {:error, _changeset} ->
        Logger.error("There was an error inserting a food truck.")
    end
  end
end
