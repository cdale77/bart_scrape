defmodule Mix.Tasks.ScraperTask do
  use Mix.Task

  def run(_args) do
    HTTPoison.start()
    BartScrape.Scraper.look_for_delays()
  end
end
