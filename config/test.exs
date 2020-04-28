use Mix.Config

# Configure your database
config :porkbrain, Porkbrain.Repo,
  username: "postgres",
  password: "",
  database: "porkbrain_test",
  hostname: "porkbrain-postgres",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :porkbrain, PorkbrainWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
