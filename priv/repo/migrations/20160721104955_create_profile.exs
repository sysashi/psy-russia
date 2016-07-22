defmodule PsyRussia.Repo.Migrations.CreateProfile do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :fullname, :string
      add :location, :string
      add :birthdate, :datetime
      add :occupation, :string

      add :psychologist_id, references(:psychologists, on_delete: :nothing)

      timestamps()
    end
    create index(:profiles, [:psychologist_id])

  end
end
