defmodule BartScrape.FetcherTest do
  use ExUnit.Case
  import Mock
  alias BartScrape.Fetcher

  @test_data """
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

  test "should return the BART API data" do
    mocked_resp = %{body: @test_data}
    with_mock HTTPoison, [get: fn(_) -> {:ok, mocked_resp} end ] do

      fetched = Fetcher.fetch_data();
      assert @test_data === fetched
    end
  end
end
