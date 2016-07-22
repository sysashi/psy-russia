defmodule PsyRussia.Repo.Migrations.CreateContact.Phone do
  use Ecto.Migration

  def change do
    create table(:contact_phones) do
      add :number, :string
      add :contact_list_id, references(:contact_lists, on_delete: :nothing)

      timestamps()
    end
    create index(:contact_phones, [:contact_list_id])

  end
end
