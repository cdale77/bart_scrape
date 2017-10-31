defmodule BartScrape.Recorder do
  use Timex
  require IEx
  alias BartScrape.{Repo, DelayRecord}
  @format_string "%a %b %d %Y %I:%M %p %Z"

  def record_delays(delay_list) do
    for delay <- delay_list do
      case delay do
        %{"@id" => _} -> record_delay(delay)
        %{} -> nil
      end
    end
  end

  defp record_delay(delay) do
    attributes = build_attributes(delay)
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
