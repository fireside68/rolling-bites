defmodule RollingBites.Repo.Migrations.ChangeSomeStringsToText do
  use Ecto.Migration

  def change do
    alter table(:food_trucks) do
      modify :food_items, :text
      modify :schedule, :text
    end
  end
end
