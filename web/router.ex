defmodule PsyRussia.Router do
  use PsyRussia.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PsyRussia do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/registration", RegistrationController, only: [:new, :create], singleton: true
    resources "/profiles", ProfileController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PsyRussia do
  #   pipe_through :api
  # end
end
