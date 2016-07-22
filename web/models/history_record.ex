defmodule PsyRussia.HistoryRecord do
  use PsyRussia.Web, :model

  schema "history_records" do
    field :in, Ecto.DateTime
    field :from, Ecto.DateTime
    field :to, Ecto.DateTime
    field :subject, :string
    field :url, :string
    belongs_to :profile, PsyRussia.Profile

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:in, :from, :to, :subject, :url])
    |> validate_required([:in, :from, :to, :subject, :url])
  end
end
