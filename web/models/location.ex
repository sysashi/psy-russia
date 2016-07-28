defmodule PsyRussia.Location do
  use PsyRussia.Web, :model

  schema "locations" do
    field :city, :string
    
    has_many :profiles, PsyRussia.Profile
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:city])
    |> validate_required([:city])
  end
end
