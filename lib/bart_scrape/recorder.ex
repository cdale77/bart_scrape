defmodule BartScrape.Recorder do
  require IEx
  alias BartScrape.{Repo, DelayRecord}

  def record_delays(delay_list) do
    for delay <- delay_list do
      changeset = DelayRecord.changeset(%DelayRecord{}, delay)
      IEx.pry
      Repo.insert(changeset)
    end
  end
end
