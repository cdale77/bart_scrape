defmodule BartScrape.Fetcher do
  def fetch_data do
    key = "MW9S-E7SL-26DU-VV8V"
    url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=#{key}&json=y"
    {status, resp} = HTTPoison.get(url)
    {status, resp.body}
  end
end
