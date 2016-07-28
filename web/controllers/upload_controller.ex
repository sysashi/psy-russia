defmodule PsyRussia.UploadController do
  use PsyRussia.Web, :controller

  def upload(conn, params) do
    IO.inspect params
    conn
    |> put_status(200)
    |> json(%{link: "http://linkto.static/file.jpg"})
  end
end
