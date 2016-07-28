defmodule PsyRussia.PageController do
  use PsyRussia.Web, :controller

  def index(conn, _params) do
    locations = PsyRussia.Location
    |> Repo.all()
    occupations = PsyRussia.Occupation
    |> Repo.all()

    render conn, "index.html", 
      locations: locations,
      occupations: occupations

  end
end
