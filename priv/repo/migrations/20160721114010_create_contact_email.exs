defmodule PsyRussia.Repo.Migrations.CreateContact.Email do
  use Ecto.Migration

  def change do
    create table(:contact_emails) do
      add :address, :string
      add :contact_list_id, references(:contact_lists, on_delete: :nothing)

      timestamps()
    end
    create index(:contact_emails, [:contact_list_id])

  end
end
