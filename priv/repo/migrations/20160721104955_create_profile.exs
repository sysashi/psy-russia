defmodule PsyRussia.Repo.Migrations.CreateProfile do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :fullname, :string
      add :birthdate, :date

      add :psychologist_id, references(:psychologists, on_delete: :nothing)
      add :location_id, references(:locations, on_delete: :nothing)

      timestamps()
    end
    create index(:profiles, [:psychologist_id])
    create index(:profiles, [:location_id])

  end
end
