defmodule RollingBites.FoodTrucks.FoodTruck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_trucks" do
    field :block, :string
    field :status, :string
    field :address, :string
    field :permit, :string
    field :location, :string
    field :approved, :string
    field :y, :string
    field :x, :string
    field :location_id, :string
    field :facility_type, :string
    field :location_description, :string
    field :blocklot, :string
    field :lot, :string
    field :food_items, :string
    field :latitude, :string
    field :longitude, :string
    field :schedule, :string
    field :days_hours, :string
    field :noi_sent, :string
    field :received, :string
    field :prior_permit, :string
    field :expiration_date, :string
    field :fire_prevention_districts, :string
    field :police_districts, :string
    field :supervisor_districts, :string
    field :zip_codes, :string
    field :neighborhoods, :string

    timestamps()
  end

  @doc false
  def changeset(food_truck, attrs) do
    food_truck
    |> cast(attrs, [:location_id, :facility_type, :location_description, :address, :blocklot, :block, :lot, :permit, :status, :food_items, :x, :y, :latitude, :longitude, :schedule, :days_hours, :noi_sent, :approved, :received, :prior_permit, :expiration_date, :location, :fire_prevention_districts, :police_districts, :supervisor_districts, :zip_codes, :neighborhoods])
    |> validate_required([:location_id, :facility_type, :location_description, :address, :blocklot, :block, :lot, :permit, :status, :food_items, :x, :y, :latitude, :longitude, :schedule, :days_hours, :noi_sent, :approved, :received, :prior_permit, :expiration_date, :location, :fire_prevention_districts, :police_districts, :supervisor_districts, :zip_codes, :neighborhoods])
  end
end
