defmodule PsyRussia.Repo.Migrations.CreateOccupation do
  use Ecto.Migration

  def change do
    create table(:occupations) do
      add :name, :string
      add :description, :text

      timestamps()
    end

  end
end
