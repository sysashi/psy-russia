defmodule PsyRussia.Psychologist do
  use PsyRussia.Web, :model

  schema "psychologists" do
    has_one :profile, PsyRussia.Profile
    has_one :registration, PsyRussia.Registration

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end

  def new(registraion, params \\ %{}) do
    changeset(%PsyRussia.Psychologist{}, params)
    |> put_assoc(:registration, registraion)
  end
end
