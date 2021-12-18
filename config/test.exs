import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :banking, Banking.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "banking_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :banking, BankingWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "9f06Q745OfHQMjFs9xk72VLi4xHVadbs+rRI6crk8SyHuH0uR07aliKqVMwgF448",
  server: false

# In test we don't send emails.
config :banking, Banking.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
