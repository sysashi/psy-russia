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

    resources "/registration", RegistrationController, 
      only: [:show, :new, :create], singleton: true
  end

  scope "/me", PsyRussia do
    resources "/profile", ProfileController, singleton: true
  end
end
