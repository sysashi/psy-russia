defmodule PsyRussia.ControllerHelpers do
  import Plug.Conn
  import Phoenix.Controller
  import Ecto

  def render_error(conn, status, assigns \\ []) do
    conn
    |> put_layout(false)
    |> put_status(status)
    |> render(PsyRussia.ErrorView, "#{status}.html", assigns)
    |> halt()
  end
end
