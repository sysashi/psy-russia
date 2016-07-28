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
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
  end

  def changeset(struct, :create, params) do
    struct 
    |> changeset(params)
    |> hash_password()
  end

  def success_registration(registration, params \\ %{}) do
    Multi.new
    |> Multi.insert(:psychologists, PsyRussia.Psychologist.new(registration))
  end

  defp hash_password(changeset) do
    if changeset.valid? do
      password = get_change(changeset, :password)
      put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
    else
      changeset
    end
  end
end
