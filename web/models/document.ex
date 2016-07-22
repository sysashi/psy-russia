defmodule PsyRussia.Document do
  use PsyRussia.Web, :model

  schema "documents" do
    field :name, :string
    field :url, :string
    belongs_to :profile, PsyRussia.Profile

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :url])
    |> validate_required([:name, :url])
  end
end
