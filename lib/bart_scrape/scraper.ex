defmodule BartScrape.Scraper do
  use GenServer
  alias BartScrape.{Fetcher, Parser, Recorder}

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    schedule_work()
    Fetcher.fetch_data |> Parser.parse_data |> Recorder.record_delays
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 0.25 * 60 * 60 * 1000) # 0.25 hrs
  end
end
