defmodule BartScrape.Scraper do
  use GenServer
  require Logger
  alias BartScrape.{Fetcher, Parser, Recorder}

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Logger.info "Starting Scraper"
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    Logger.info "Looking for delays"
    schedule_work()
    Fetcher.fetch_data |> Parser.parse_data |> Recorder.record_delays
    {:noreply, state}
  end

  defp schedule_work() do
    interval = 15 * 60 * 1000 # 15 min
    Process.send_after(self(), :work, interval)
  end
end
