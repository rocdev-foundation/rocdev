# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :rocdev,
  ecto_repos: [Rocdev.Repo]

# Configures the endpoint
config :rocdev, RocdevWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HvI0+YAfS1rWGW2PWdeKmLrL3VCwwPxHHjqoL0Ts4uVJM/FptA7pf011mV9wiPBc",
  render_errors: [view: RocdevWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Rocdev.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
