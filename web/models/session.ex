defmodule PsyRussia.Session do
  use PsyRussia.Web, :model

  schema "session" do
    field :email
    field :password
  end

  @required_fields [:email, :password]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
  end
end
