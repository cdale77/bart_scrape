defmodule BartScrape.Recorder do
  use Timex
  require Logger
  alias BartScrape.{Repo, DelayRecord}
  import Ecto.Query

  @format_string "%a %b %d %Y %I:%M %p %Z"

  def record_delays(delay_list) do
    for delay <- delay_list do
      case delay do
        %{"@id" => _} -> record_delay(delay)
        %{} -> Logger.info("no delays found")
      end
    end
  end

  defp record_delay(delay) do
    Logger.info("delays found!" <> inspect(delay))

    record = Repo.one(from d in DelayRecord, order_by: [desc: d.id], limit: 1)

    case record do
      nil -> persist_record(delay)
      previous_delay -> check_for_dupes(previous_delay, delay) 
    end

  end

  defp check_for_dupes(previous_delay, current_delay) do
    case is_duplicate?(previous_delay, current_delay) do
      true -> persist_record(current_delay)
      false -> increment_timestamp(previous_delay)
    end
  end

  defp increment_timestamp(previous_delay) do
    timestamp = Ecto.DateTime.utc |> Ecto.DateTime.to_iso8601
    previous_delay
    |> Ecto.Changeset.cast(%{ updated_at: timestamp }, [:updated_at])
    |> Repo.update!
  end

  defp is_duplicate?(previous_delay, current_delay) do
    previous_delay.bart_id == current_delay["@id"]
  end

  defp persist_record(delay) do
    attributes = build_attributes(delay)
    Logger.info("building changeset: " <> inspect attributes)
    changeset = DelayRecord.changeset(%DelayRecord{}, attributes)
    Logger.info("changeset: " <> inspect(changeset))
    Repo.insert(changeset)
  end

  defp build_attributes(delay) do
    Logger.info("building attributes")
    %{
      bart_id: delay["@id"],
      delay_type: delay["type"],
      station: delay["station"],
      posted: parse_time(delay["posted"]),
      sms_text: delay["sms_text"]["#cdata-section"]
    }
  end

  defp parse_time(time_string) do
    case Timex.parse(time_string, @format_string, :strftime) do
      {:ok, time} -> time
      _ -> nil
    end
  end
end
