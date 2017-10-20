defmodule BartScrape.Recorder do
  use ExUnit.Case
  alias BartScrape.Recorder

  @delays [
        %{
          "@id"              => "159007",
          "description"      => %{
            "#cdata-section" => "BART is recovering from an earlier problem."
          },
          "expires"          => "Thu Dec 31 2037 11:59 PM PST",
          "posted"           => "Wed Oct 18 2017 05:36 PM PDT",
          "sms_text"         => %{
            "#cdata-section" => "BART recovering: 10 min delay on SF line."
          },
          "station"          => "BART",
          "type"             => "DELAY"
        }
      ]

  @no_delays [
        %{
          "description" => %{"#cdata-section" => "No delays reported."},
          "sms_text"    => %{"#cdata-section" => "No delays reported."},
          "station"     => ""
        }
      ]

  describe "with no delays" do
    test "should not persist any records in the db" do

    end
  end

  describe "with delays" do
    test "should persist records in the db" do

    end
  end
end
