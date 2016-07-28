defmodule PsyRussia.Profile do
  use PsyRussia.Web, :model
  
  schema "profiles" do
    belongs_to :psychologist, PsyRussia.Psychologist

    field :fullname, :string
    field :picture, :string
    field :birthdate, Ecto.Date

    belongs_to :location, PsyRussia.Location
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
    |> update_location()
    |> change()
  end

  def changeset(struct, :secondary_fields, params) do
    struct
    |> cast(params, @secondary_fields)
    |> cast_assoc(:documents, required: true)
    |> validate_required(@secondary_fields)
  end

  def changeset(struct, :contact_list, params) do
    struct
  end

  def update_location(changeset) do
    case changeset do 
      %Ecto.Changeset{changes: %{location_id: id}, valid?: true} ->
        profile = PsyRussia.Repo.get!(PsyRussia.Location, id)
        |> PsyRussia.Location.build(changeset)

        IO.inspect profile
        profile
      _ ->
        changeset
    end
  end
end
