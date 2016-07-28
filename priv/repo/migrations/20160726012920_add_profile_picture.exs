defmodule PsyRussia.Repo.Migrations.AddProfilePicture do
  use Ecto.Migration

  def change do
    alter table(:profiles) do
      add :picture, :string
    end
  end
end
