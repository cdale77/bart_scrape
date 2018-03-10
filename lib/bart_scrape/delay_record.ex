defmodule BartScrape.DelayRecord do
  use Ecto.Schema
  import Ecto.Changeset
  alias BartScrape.DelayRecord

  schema "delay_records" do
    field :bart_id, :integer
    field :delay_type, :string
    field :posted, :naive_datetime
    field :station, :string
    field :desc_text, :string
    field :sms_text, :string

    timestamps()
  end

  @doc false
  def changeset(%DelayRecord{} = delay_record, attrs) do
    delay_record
    |> cast(attrs, [
      :bart_id,
      :station,
      :delay_type,
      :posted,
      :desc_text,
      :sms_text
    ])
  end
end
