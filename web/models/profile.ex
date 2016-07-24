defmodule PsyRussia.Profile do
  use PsyRussia.Web, :model
  
  schema "profiles" do
    belongs_to :psychologist, PsyRussia.Psychologist

    field :fullname, :string
    field :location, :string
    field :occupation, :string
    field :birthdate, Ecto.DateTime

    has_one :contact_list, PsyRussia.ContactList

    has_many :education_records, PsyRussia.HistoryRecord
    has_many :employment_records, PsyRussia.HistoryRecord
    has_many :documents, PsyRussia.Document

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:fullname, :location, :birthdate, :occupation])
    |> validate_required([:fullname, :location, :birthdate, :occupation])
  end
end
