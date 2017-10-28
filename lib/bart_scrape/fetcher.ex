defmodule BartScrape.Fetcher do
  def fetch_data do
    key = "MW9S-E7SL-26DU-VV8V"
    url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=#{key}&json=y"
    {_, resp} = HTTPoison.get(url)
    resp.body
  end
end
