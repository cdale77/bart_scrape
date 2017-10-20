defmodule BartScrape.Parser do
  def parse_data(json_string) do
    parse_json(json_string) |> find_delays
  end

  defp parse_json(json_string) do
    Poison.Parser.parse!(json_string)
  end

  defp find_delays(json_map) do
    json_map["root"]["bsa"]
  end
end
