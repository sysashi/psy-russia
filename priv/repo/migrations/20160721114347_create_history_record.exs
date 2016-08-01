defmodule PsyRussia.Repo.Migrations.CreateHistoryRecord do
  use Ecto.Migration

  def change do
    create table(:history_records) do
      add :from, :date
      add :to, :date
      add :subject, :string
      add :url, :string
      add :profile_id, references(:profiles, on_delete: :nothing)

      timestamps()
    end
    create index(:history_records, [:profile_id])

  end
end
