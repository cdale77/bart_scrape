defmodule BartScrape.FetcherTest do
  use ExUnit.Case

  test "should return the BART API data" do
    test_data = ~s"""
      {
        "?xml": {
          "@version": "1.0",
          "@encoding": "utf-8"
        },
        "root": {
          "@id": "1",
          "uri": {
            "#cdata-section": "http:\/\/api.bart.gov\/api\/bsa.aspx?cmd=bsa&json=y"
          },
          "date": "10\/04\/2017",
          "time": "20:56:00 PM PDT",
          "bsa": [
            {
              "station": "",
              "description": {
                "#cdata-section": "No delays reported."
              },
              "sms_text": {
                "#cdata-section": "No delays reported."
              }
            }
          ],
          "message": ""
        }
      }
    """

    {:ok, fetched } = BartScrape.Fetcher.fetch_data();
    assert test_data === fetched
  end
end
