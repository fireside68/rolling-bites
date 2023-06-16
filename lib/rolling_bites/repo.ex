defmodule RollingBites.Repo do
  use Ecto.Repo,
    otp_app: :rolling_bites,
    adapter: Ecto.Adapters.Postgres
end
