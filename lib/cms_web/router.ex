defmodule CmsWeb.Router do
  use CmsWeb, :router

  pipeline :preparations do
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CmsWeb do
    pipe_through [:preparations, :browser] # Use the default browser stack

    get "/", PageController, :index
    resources "/edit_mode", EditModeController, only: [:create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  scope "/", CmsWeb do
    pipe_through [:preparations, :api]

    resources "/blocks", BlockController, only: [:update], singleton: true
  end
end
