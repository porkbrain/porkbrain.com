use Mix.Config

# Configure your database
config :bausano, Bausano.Repo,
  username: "postgres",
  password: "postgres",
  database: "bausano_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bausano, BausanoWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
