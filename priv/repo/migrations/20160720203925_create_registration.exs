defmodule PsyRussia.Repo.Migrations.CreateRegistration do
  use Ecto.Migration

  def change do
    create table(:registrations) do
      add :email, :string
      add :password_hash, :string
      add :status, :string, default: "new"

      add :psychologist_id, references(:psychologists, on_delete: :nothing)

      timestamps()
    end
    
    create constraint(:registrations, :only_allowed_status, 
      check: "status in ('new', 'pending', 'confirmed')")

  end
end
