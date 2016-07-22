defmodule PsyRussia.Contact.Phone do
  use PsyRussia.Web, :model

  schema "contact_phones" do
    field :number, :string
    belongs_to :contact_list, PsyRussia.ContactList

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:number])
    |> validate_required([:number])
  end
end
