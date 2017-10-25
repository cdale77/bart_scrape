defmodule BartScrape.RecorderTest do
  use BartScrape.ModelCase
  alias BartScrape.{Repo, Recorder, DelayRecord}

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
      Recorder.record_delays(@no_delays)
      count = Repo.one(from d in DelayRecord, select: count(d.id))
      assert 0 == count
    end
  end

  describe "with delays" do
    test "should persist records in the db" do
      Recorder.record_delays(@delays)
      count = Repo.one(from d in DelayRecord, select: count(d.id))
      assert 1 == count
    end
  end
end
