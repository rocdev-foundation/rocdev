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
    get "/meetup", MeetupController, :index
    get "/github", SocialController, :github

    delete "/subscriptions", SubscriptionController, :delete
  end

  scope "/slack", RocdevWeb do
    pipe_through :browser

    get "/", SlackController, :index
    post "/registration", SlackController, :register
  end

  # Other scopes may use custom stacks.
  # scope "/api", RocdevWeb do
  #   pipe_through :api
  # end
end
