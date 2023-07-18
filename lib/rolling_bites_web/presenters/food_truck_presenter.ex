defmodule RollingBitesWeb.FoodTruckPresenter do
  alias RollingBitesWeb.FoodTruckHelper

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          address: String.t(),
          days_hours: map(),
          description: String.t(),
          latitude: float(),
          longitude: float(),
          schedule_url: String.t()
        }

  defstruct [
    :id,
    :name,
    :address,
    :days_hours,
    :description,
    :latitude,
    :longitude,
    :schedule_url
  ]

  def from_api_data(data) do
    %__MODULE__{
      id: data["objectid"],
      name: data["applicant"],
      address: data["address"],
      days_hours: FoodTruckHelper.parse_schedule(data["dayshours"]),
      description: FoodTruckHelper.parse_food_items(data["fooditems"]),
      latitude: data["latitude"],
      longitude: data["longitude"],
      schedule_url: data["schedule"]
    }
  end
end
