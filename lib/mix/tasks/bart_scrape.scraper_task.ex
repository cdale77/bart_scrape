defmodule Mix.Tasks.ScraperTask do
  @moduledoc """
  A task to allow the scraper to be run by the heroku scheduler.
  """
  use Mix.Task

  def run(_args) do
    Mix.Task.run "app.start", []
    BartScrape.Scraper.look_for_delays()
  end
end
