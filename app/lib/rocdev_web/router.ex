defmodule RocdevWeb.Router do
  use RocdevWeb, :router

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

  scope "/", RocdevWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/unsubscribe", SubscriptionController, :unsubscribe

    delete "/subscriptions", SubscriptionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", RocdevWeb do
  #   pipe_through :api
  # end
end
