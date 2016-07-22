defmodule PsyRussia.Repo.Migrations.CreateContact.OnlineService do
  use Ecto.Migration

  def change do
    create table(:contact_online_services) do
      add :type, :string
      add :value, :string
      add :contact_list_id, references(:contact_lists, on_delete: :nothing)

      timestamps()
    end
    create index(:contact_online_services, [:contact_list_id])

  end
end
