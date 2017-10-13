defmodule BartScrape.ParserTest do
  use ExUnit.Case
  alias BartScrape.Parser

  @delays """
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

  @no_delays """
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

  describe "with no delays" do
    test "should not return data" do
      assert {:no_delays} = Parser.parse_data(@no_delays)
    end
  end

  describe "with delays" do
    test "should return data" do
      assert {:ok, delays} = Parser.parse_data(@delays)
    end
  end
end
