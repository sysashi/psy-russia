defmodule PsyRussia.Psychologist do
  use PsyRussia.Web, :model

  schema "psychologists" do
    has_one :profle, PsyRussia.Profile
    has_one :registraion, PsyRussia.Registration

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
end
