defmodule PsyRussia.Registration do
  use PsyRussia.Web, :model

  schema "registrations" do
    field :email, :string
    field :status, :string, default: "new"
    field :password_hash, :string
    field :password, :string, virtual: true

    belongs_to :psychologist, PsyRussia.Psychologist

    timestamps()
  end

  @required_fields [:email, :password]
  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
