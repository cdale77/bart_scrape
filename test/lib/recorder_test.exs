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

    test "should not persist duplicate delay records" do
      Recorder.record_delays(@delays)
      Recorder.record_delays(@delays)
      count = Repo.one(from d in DelayRecord, select: count(d.id))
      assert 1 == count
    end

    test "should persist delay records with the same time but not id" do
      delays1 = @delays |> List.first |> Map.put("id", "123456")
      Recorder.record_delays([delays1])
      Recorder.record_delays(@delays)
      count = Repo.one(from d in DelayRecord, select: count(d.id))
      assert 1 == count
    end

    test "should save the proper fields" do
      Recorder.record_delays(@delays)
      record = Repo.one(from d in DelayRecord, limit: 1)
      assert record.bart_id == 159007
      assert record.delay_type == "DELAY"
      assert record.station == "BART"
      expected = NaiveDateTime.to_iso8601(record.posted)
      assert expected == "2017-10-18T17:36:00.000000"
      assert record.sms_text == "BART recovering: 10 min delay on SF line."
    end
  end
end
