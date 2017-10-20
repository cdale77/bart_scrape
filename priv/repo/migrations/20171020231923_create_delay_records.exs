defmodule BartScrape.Repo.Migrations.CreateDelayRecords do
  use Ecto.Migration

  def change do
    create table(:delay_records) do
      add :bart_id, :integer
      add :station, :string
      add :delay_type, :string
      add :posted, :naive_datetime

      timestamps()
    end

  end
end
