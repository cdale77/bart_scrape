defmodule Mix.Tasks.CleanerTask do
  @moduledoc """
  A task to clean duplicate delay records in the db. The duplicates were
  created from the original implementation of the app.
  """

  use Mix.Task
  require Logger
  alias BartScrape.{Repo, DelayRecord}
  import Ecto.Query

  def run(_args) do
    Mix.Task.run "app.start", []
    delay_records = DelayRecord |> Repo.all
    process_record(delay_records)
  end

  def process_record([]) do
    Logger.info("Done")
  end

  def process_record([record|records]) do
    [next_record|_] = records
    Logger.info("current record id: " <> Integer.to_string(record.id))
    Logger.info("next record id: " <> Integer.to_string(next_record.id))
    Logger.info('------------------------------------------------------------')

    compare_records(record, next_record)
    process_record(records)
  end

  def compare_records(current_record, next_record) do
    case is_dupe?(current_record, next_record) do
      true -> update_timestamp(current_record)
    end
  end

  def is_dupe?(current_record, next_record) do
    current_record.bart_id == next_record.bart_id
  end

  def update_timestamp(current_record) do

  end
end
