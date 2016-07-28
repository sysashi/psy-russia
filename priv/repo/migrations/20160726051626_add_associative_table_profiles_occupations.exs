defmodule PsyRussia.Repo.Migrations.AddAssociativeTableProfilesOccupations do
  use Ecto.Migration

  def change do
    create table(:profiles_occupations, primary_key: false) do
      add :profile_id, references(:profiles)
      add :occupation_id, references(:occupations)
    end
  end
end
