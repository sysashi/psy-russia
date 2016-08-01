defmodule PsyRussia.Auth do
  import Plug.Conn
  import Phoenix.Controller
  import PsyRussia.Router.Helpers

  alias PsyRussia.{Repo, Registration}


  def authorize(conn, params) do
    who = Keyword.get(params, :who, :psychologist) 

    case get_session(conn, who) do
      nil ->
        conn
        |> redirect(to: session_path(conn, :delete))
      id -> 
        module = auth?(who)
        entity = Repo.get(module, id)

        assign(conn, who, entity)
    end
  end

  def psychologist_auth(email, password) do
    if (reg = Repo.get_by(Registration, email: email)) &&
        Comeonin.Bcrypt.checkpw(password, reg.password_hash) do
      reg = reg |> Repo.preload(:psychologist)
      {:ok, reg.psychologist}
    else
      Comeonin.Bcrypt.dummy_checkpw()
      {:error, nil}
    end
  end

  defp auth?(:psychologist) do
    PsyRussia.Psychologist
  end

  defp auth?(_), do: nil
end
