defmodule PsyRussia.Repo.Migrations.CreateDocument do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :name, :string
      add :url, :string
      add :profile_id, references(:profiles, on_delete: :nothing)

      timestamps()
    end
    create index(:documents, [:profile_id])

  end
end
