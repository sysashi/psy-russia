defmodule PsyRussia.Contact.OnlineService do
  use PsyRussia.Web, :model

  schema "contact_online_services" do
    field :type, :string
    field :value, :string
    belongs_to :contact_list, PsyRussia.ContactList

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type, :value])
    |> validate_required([:type, :value])
  end
end
