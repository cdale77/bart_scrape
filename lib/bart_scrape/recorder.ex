defmodule BartScrape.Recorder do
  use Timex
  require IEx
  alias BartScrape.{Repo, DelayRecord}
  @format_string "%a %b %d %Y %I:%M %p %Z"

  def record_delays(delay_list) do
    for delay <- delay_list do
      case delay do
        %{"@id" => _} ->
          attributes = %{
            bart_id: delay["@id"],
            delay_type: delay["type"],
            station: delay["station"],
            posted: parse_time(delay["posted"])
          }

          changeset = DelayRecord.changeset(%DelayRecord{}, attributes)
          Repo.insert(changeset)
        %{} -> nil
      end
    end
  end

  defp parse_time(time_string) do
    case Timex.parse(time_string, @format_string, :strftime) do
      {:ok, time} -> time
      _ -> nil
    end
  end
end
