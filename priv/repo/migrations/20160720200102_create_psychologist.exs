defmodule PsyRussia.Repo.Migrations.CreatePsychologist do
  use Ecto.Migration

  def change do
    create table(:psychologists) do
      # add :registration_id, references(:registrations, on_delete: :nothing)
      # add :profile_id, references(:profiles, on_delete: :nothing)

      timestamps()
    end

    # create index(:psychologists, [:registration_id])
    # create index(:psychologists, [:profile_id])
  end
end
