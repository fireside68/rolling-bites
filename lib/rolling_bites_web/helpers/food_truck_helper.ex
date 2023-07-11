defmodule RollingBitesWeb.FoodTruckHelper do
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
end
