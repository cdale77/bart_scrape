defmodule BartScrape.Recorder do
  use Timex
  require IEx
  alias BartScrape.{Repo, DelayRecord}

  def record_delays(delay_list) do
    for delay <- delay_list do
      case delay do
        %{"@id" => _} ->
          attributes = %{
            bart_id: delay["@id"],
            delay_type: delay["type"],
            station: delay["station"]
          }
          time = Timex.parse(delay["posted"], "%a %b %d %Y %I:%M %p %Z", :strftime)
          changeset = DelayRecord.changeset(%DelayRecord{}, attributes)
          IEx.pry
          Repo.insert(changeset)
        %{} ->
      end
    end
  end
end
