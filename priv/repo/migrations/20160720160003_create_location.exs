defmodule PsyRussia.Repo.Migrations.CreateLocation do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :city, :string
    end
  end
end
