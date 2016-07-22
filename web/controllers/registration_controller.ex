defmodule PsyRussia.RegistrationController do
  use PsyRussia.Web, :controller

  alias PsyRussia.Registration

  def index(conn, _params) do
    registrations = Repo.all(Registration)
    render(conn, "index.html", registrations: registrations)
  end

  def new(conn, _params) do
    changeset = Registration.changeset(%Registration{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"registration" => registration_params}) do
    changeset = Registration.changeset(%Registration{}, registration_params)

    case Repo.insert(changeset) do
      {:ok, _registration} ->
        conn
        |> put_flash(:info, "Registration created successfully.")
        |> redirect(to: registration_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    registration = Repo.get!(Registration, id)
    render(conn, "show.html", registration: registration)
  end

  def edit(conn, %{"id" => id}) do
    registration = Repo.get!(Registration, id)
    changeset = Registration.changeset(registration)
    render(conn, "edit.html", registration: registration, changeset: changeset)
  end

  def update(conn, %{"id" => id, "registration" => registration_params}) do
    registration = Repo.get!(Registration, id)
    changeset = Registration.changeset(registration, registration_params)

    case Repo.update(changeset) do
      {:ok, registration} ->
        conn
        |> put_flash(:info, "Registration updated successfully.")
        |> redirect(to: registration_path(conn, :show, registration))
      {:error, changeset} ->
        render(conn, "edit.html", registration: registration, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    registration = Repo.get!(Registration, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(registration)

    conn
    |> put_flash(:info, "Registration deleted successfully.")
    |> redirect(to: registration_path(conn, :index))
  end
end
