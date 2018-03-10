defmodule BartScrape.Repo.Migrations.AddFieldsToDelayRecords do
  use Ecto.Migration

  def change do
    alter table(:delay_records) do
      add :desc_text, :text
      add :sms_text, :text
    end
  end
end
