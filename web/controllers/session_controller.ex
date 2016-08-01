defmodule PsyRussia.SessionController do
  use PsyRussia.Web, :controller
  import PsyRussia.Auth
  alias PsyRussia.Session

  plug :scrub_params, "session" when action == :create

  def new(conn, _params) do
    changeset = Session.changeset(%Session{})

    conn
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"session" => session_params}) do
    changeset = Session.changeset(%Session{}, session_params)

    just_changeset = fn -> 
      conn
      |> render("new.html", changeset: changeset)
    end

    case changeset do
      %Ecto.Changeset{valid?: true, 
       changes: %{email: email, password: password}} -> 
      case psychologist_auth(email, password) do
        {:ok, psycho} ->
          conn
          |> put_session(:psychologist, psycho.id)
          |> redirect(to: "/me/profile/edit?step=1")
        {:error, _} ->
          just_changeset.()
      end
      _ ->
        just_changeset.()
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:psychologist)
    |> redirect(to: "/")
  end
end
