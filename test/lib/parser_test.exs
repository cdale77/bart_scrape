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
      "date": "10\/18\/2017",
      "time": "18:23:00 PM PDT",
      "bsa": [
        {
          "@id": "159007",
          "station": "BART",
          "type": "DELAY",
          "description": {
            "#cdata-section": "BART is recovering from an earlier problem."
          },
          "sms_text": {
            "#cdata-section": "BART recovering: 10 min delay on SF line."
          },
          "posted": "Wed Oct 18 2017 05:36 PM PDT",
          "expires": "Thu Dec 31 2037 11:59 PM PST"
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
    test "should return the no-delay section as a map" do
      returned = Parser.parse_data(@no_delays)
      expected = [
        %{
          "description" => %{"#cdata-section" => "No delays reported."},
          "sms_text"    => %{"#cdata-section" => "No delays reported."},
          "station"     => ""
        }
      ]
      assert expected == returned
    end
  end

  describe "with delays" do
    test "should return data" do
      returned = Parser.parse_data(@delays)
      expected = [
        %{
          "@id" => "159007",
          "description" => %{
            "#cdata-section" => "BART is recovering from an earlier problem."
          },
          "expires" => "Thu Dec 31 2037 11:59 PM PST",
          "posted" => "Wed Oct 18 2017 05:36 PM PDT",
          "sms_text" => %{
            "#cdata-section" => "BART recovering: 10 min delay on SF line."
          },
          "station" => "BART", "type" => "DELAY"
        }
      ]

      assert expected == returned
    end
  end
end
