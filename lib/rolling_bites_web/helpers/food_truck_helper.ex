defmodule RollingBitesWeb.FoodTruckHelper do
  @earth_radius_km 6371.0

  @spec parse_food_items(nil | String.t()) :: String.t()
  def parse_food_items(nil), do: ""

  def parse_food_items(food_items) do
    case String.contains?(food_items, ":") do
      true -> process_food_items(food_items)
      _ -> food_items
    end
  end

  defp process_food_items(food_items) do
    food_items
    |> String.split(~r/:\s*/)
    |> Enum.join(", ")
  end

  def group_and_sort_trucks(truck_data) do
    truck_data =
      truck_data
      |> Enum.group_by(& &1.name)
      |> Enum.sort()

    Enum.map(truck_data, fn {name, entities} ->
      %{name: name, entities: entities}
    end)
  end

  def haversine_distance({lat1, lon1}, {lat2, lon2}) do
    dlat = to_radians(lat2 - lat1)
    dlon = to_radians(lon2 - lon1)

    a =
      :math.sin(dlat / 2) * :math.sin(dlat / 2) +
        :math.cos(to_radians(lat1)) * :math.cos(to_radians(lat2)) *
          :math.sin(dlon / 2) * :math.sin(dlon / 2)

    c = 2 * :math.atan2(:math.sqrt(a), :math.sqrt(1 - a))
    @earth_radius_km * c
  end

  defp to_radians(degrees) do
    degrees * :math.pi() / 180
  end

  def parse_schedule(schedule) do
    # Define mapping from day abbreviations to full names
    day_map = %{
      "Mo" => "Monday",
      "Tu" => "Tuesday",
      "We" => "Wednesday",
      "Th" => "Thursday",
      "Fr" => "Friday",
      "Sa" => "Saturday",
      "Su" => "Sunday"
    }

    # Initialize map to store parsed schedule
    parsed_schedule = %{
      "Monday" => [],
      "Tuesday" => [],
      "Wednesday" => [],
      "Thursday" => [],
      "Friday" => [],
      "Saturday" => [],
      "Sunday" => []
    }

    # Split schedule into separate blocks
    String.split(schedule, ";")
    |> Enum.reduce(parsed_schedule, fn block, acc ->
      # Split block into days and hours
      [days, hours] = String.split(block, ":")
      # Convert day abbreviations to full names
      days = String.split(days, "/")
      |> Enum.map(&Map.get(day_map, &1))
      # Add hours to corresponding days in parsed schedule
      Enum.reduce(days, acc, fn day, acc ->
        Map.put(acc, day, [hours | Map.get(acc, day)])
      end)
    end)
  end
end
