defmodule BartScrape.Scraper do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    # scrape here
    # 1) fetch data
    # 2) parse it and look for delays
    # 3) save it if anything found
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 0.25 * 60 * 60 * 1000) # 0.25 hrs
  end
end
