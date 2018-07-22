defmodule BartScrape.Recorder do
  use Timex
  require Logger
  alias BartScrape.{Repo, DelayRecord}
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
