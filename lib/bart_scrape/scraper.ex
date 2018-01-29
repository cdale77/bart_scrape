defmodule BartScrape.Scraper do
  require Logger
  alias BartScrape.{Fetcher, Parser, Recorder}


  def look_for_delays do
    Logger.info "Looking for delays"
    Fetcher.fetch_data |> Parser.parse_data |> Recorder.record_delays
  end
end
