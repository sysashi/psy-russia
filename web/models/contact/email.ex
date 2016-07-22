defmodule PsyRussia.Contact.Email do
  use PsyRussia.Web, :model

  schema "contact_emails" do
    field :address, :string
    belongs_to :contact_list, PsyRussia.ContactList

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:address])
    |> validate_required([:address])
  end
end
