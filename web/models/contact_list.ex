defmodule PsyRussia.ContactList do
  use PsyRussia.Web, :model

  schema "contact_lists" do
    belongs_to :profile, PsyRussia.Profile
    has_many :phone_contacts, PsyRussia.Contact.Phone
    has_many :email_contacts, PsyRussia.Contact.Email
    has_many :online_service_contacts, PsyRussia.Contact.OnlineService

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:profile_id])
    |> assoc_constraint(:profile)
    |> cast_assoc(:phone_contacts)
    |> cast_assoc(:email_contacts)
  end
end
