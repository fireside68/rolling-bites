defmodule RollingBitesWeb.FoodTruckPresenter do
  alias RollingBitesWeb.LeafletHelper

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          address: String.t(),
          description: String.t(),
          latitude: float(),
          longitude: float(),
          schedule_url: String.t()
        }

  defstruct [
    :id,
    :name,
    :address,
    :description,
    :latitude,
    :longitude,
    :schedule_url
  ]

  def from_api_data(data) do
    latitude = parse_map_point(data["latitude"])
    longitude = parse_map_point(data["longitude"])
    name = data["applicant"]

    %__MODULE__{
      id: data["objectid"],
      name: name,
      address: data["address"],
      description: data["fooditems"],
      latitude: latitude,
      longitude: longitude,
      schedule_url: data["schedule"]
    }
  end

  defp parse_map_point(map_point) do
    case Float.parse(map_point) do
      {float, ""} -> float
      :error -> String.to_integer(map_point)
    end
  end
end
