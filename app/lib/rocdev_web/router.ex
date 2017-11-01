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
    pipe_through :browser

    get "/", PageController, :index
    get "/code-of-conduct", PageController, :code_of_conduct
    get "/unsubscribe", SubscriptionController, :unsubscribe

    delete "/subscriptions", SubscriptionController, :delete
  end

  scope "/social", RocdevWeb do
    pipe_through :browser

    get "/", SocialController, :index
    get "/slack", SocialController, :slack
    get "/meetup", SocialController, :meetup
    get "/github", SocialController, :github
  end

  # Other scopes may use custom stacks.
  # scope "/api", RocdevWeb do
  #   pipe_through :api
  # end
end
