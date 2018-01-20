defmodule Mix.Tasks.BartScrape.ScraperTask do
  use Mix.Task

  def run(_args) do
    {:ok, pid} = BartScrape.Scraper.start_link()
    send(pid, :work)
  end
end
