defmodule PsyRussia.PageController do
  use PsyRussia.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
