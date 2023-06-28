defmodule RollingBitesWeb.FoodTruckClientBehaviour do
  @callback fetch_all_data() :: {:ok, any()} | {:error, any()}
  @callback fetch_by_id(String.t() | integer()) :: {:ok, any()} | {:error, any()}
end
