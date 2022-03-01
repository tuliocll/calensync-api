import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :calendarAPI, CalendarAPI.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "calendarapi_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :calendarAPI, CalendarAPIWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "b+ymArm/++9m4qgfLSGOlKvRv3lsFRQh0MfBWvtZbTf8Nz3P/WRX9APhAqzSNhca",
  server: false

# In test we don't send emails.
config :calendarAPI, CalendarAPI.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
