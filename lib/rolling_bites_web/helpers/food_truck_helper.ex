defmodule RollingBitesWeb.FoodTruckHelper do

  def parse_food_items(nil), do: ""
  def parse_food_items(food_items) do
    case String.contains?(food_items, ":") do
      true -> process_food_items(food_items)
      _ -> food_items
    end
  end

  def process_food_items(food_items) do
    food_items
    |> String.split(~r/:\s*/)
    |> Enum.join(", ")
  end
end
