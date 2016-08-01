defmodule PsyRussia.RegistrationController do
  use PsyRussia.Web, :controller

  alias PsyRussia.Registration

  def show(conn, _params) do
    redirect conn, to: registration_path(conn, :new)
  end

  def new(conn, _params) do
    changeset = Registration.changeset(%Registration{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"registration" => registration_params}) do
    changeset = Registration.changeset(%Registration{}, :create, registration_params)

    case Repo.insert(changeset) do
      {:ok, registration} ->

        psychologist = PsyRussia.Psychologist.new(registration)
        |> Repo.insert!()

        new_profile = psychologist
        |> Ecto.build_assoc(:profile)
        |> Repo.insert!()

        conn
        |> put_session(:psychologist, psychologist.id)
        |> put_flash(:info, "Registration created successfully.")
        |> redirect(to: profile_path(conn, :edit, step: 1))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
