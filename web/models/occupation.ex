defmodule PsyRussia.Occupation do
  use PsyRussia.Web, :model

  schema "occupations" do
    field :name, :string
    field :description, :string

    many_to_many :profiles, PsyRussia.Profile, join_through: "profiles_occupations"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name, :description])
  end
end
