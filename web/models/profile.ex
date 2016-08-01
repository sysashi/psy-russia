defmodule PsyRussia.Profile do
  use PsyRussia.Web, :model
  
  schema "profiles" do
    belongs_to :psychologist, PsyRussia.Psychologist

    field :fullname, :string
    field :picture, :string
    field :birthdate, Ecto.Date

    belongs_to :location, PsyRussia.Location, on_replace: :nilify

    many_to_many :occupations, 
      PsyRussia.Occupation, join_through: "profiles_occupations"

    field :occupations_ids, {:array, :string}, virtual: true

    has_one :contact_list, PsyRussia.ContactList

    has_many :education_records, PsyRussia.HistoryRecord
    has_many :employment_records, PsyRussia.HistoryRecord
    has_many :documents, PsyRussia.Document

    timestamps()
  end

  @primary_fields [:fullname, :birthdate, :picture, :location_id]
  @secondary_fields [:occupations_ids]

  def update_changeset(struct, :all, params) do
    struct
    |> changeset(params)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> changeset(:psychologist, params)
  end

  def changeset(struct, :psychologist, params) do
    struct
    |> cast(params, [:psychologist_id])
    |> validate_required([:psychologist_id])
    |> assoc_constraint(:psychologist)
  end

  def changeset(struct, :primary_fields, params) do
    struct 
    |> cast(params, @primary_fields)
    |> validate_required(@primary_fields)
  end

  def changeset(struct, :secondary_fields, params) do
    struct
    |> cast(params, @secondary_fields)
    |> validate_required(@secondary_fields)
    |> cast_assoc(:documents, required: true)
    |> cast_assoc(:occupations, required: true)
  end

  def changeset(struct, :contact_list, params) do
    struct
    |> cast(params, [])
    |> cast_assoc(:contact_list, required: true)
  end
  
  defp everything(struct, params) do
    struct
    |> changeset(:psychologist, params)
    |> changeset(:primary_fields, params)
    |> changeset(:secondary_fields, params)
    |> changeset(:contact_list, params)
  end
end
