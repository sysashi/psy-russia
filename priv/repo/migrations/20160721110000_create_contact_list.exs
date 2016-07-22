defmodule PsyRussia.Repo.Migrations.CreateContactList do
  use Ecto.Migration

  def change do
    create table(:contact_lists) do
      add :profile_id, references(:profiles, on_delete: :nothing)

      timestamps()
    end
    create index(:contact_lists, [:profile_id])

  end
end
