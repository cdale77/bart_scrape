defmodule BartScrape.Recorder do
  use Timex
  require IEx
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
    Logger.info("delays found!")
    attributes = build_attributes(delay)
    Logger.info("building changeset: " <> inspect(delay))
    changeset = DelayRecord.changeset(%DelayRecord{}, attributes)
    Repo.insert(changeset)
  end

  defp build_attributes(delay) do
    %{
      bart_id: delay["@id"],
      delay_type: delay["type"],
      station: delay["station"],
      posted: parse_time(delay["posted"])
    }
  end

  defp parse_time(time_string) do
    case Timex.parse(time_string, @format_string, :strftime) do
      {:ok, time} -> time
      _ -> nil
    end
  end
end
