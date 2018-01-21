# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :rocdev,
  ecto_repos: [Rocdev.Repo],
  slack_invite_base_url: System.get_env("SLACK_INVITE_API_BASE"),
  slack_invite_api_token: System.get_env("SLACK_INVITE_API_TOKEN"),
  slack_api_base_url: System.get_env("SLACK_API_BASE"),
  slack_api_token: System.get_env("SLACK_API_TOKEN")

# Configures the endpoint
config :rocdev, RocdevWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("ROCDEV_SECRET_KEY_BASE") || "HvI0+YAfS1rWGW2PWdeKmLrL3VCwwPxHHjqoL0Ts4uVJM/FptA7pf011mV9wiPBc",
  render_errors: [view: RocdevWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Rocdev.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :sparkpost,
  api_key: System.get_env("SPARKPOST_API_KEY"),
  http_timeout: 5000,
  http_conn_timeout: 8000

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
