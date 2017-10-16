use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rocdev, RocdevWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :rocdev, Rocdev.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "rocdev_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox


config :sparkpost,
  api_endpoint: "http://localhost:4321/",
  api_key: "TESTKEY",
  http_timeout: 5000,
  http_conn_timeout: 8000
