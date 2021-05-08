# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tiltify,
  ecto_repos: [Tiltify.Repo]

# Configures the endpoint
config :tiltify, TiltifyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "I38lQ/PmTHpl023uAQXADvnAzbcrjI8xawfgTJEQ3IwtK+hHT/2xWOuxrQ51bZop",
  render_errors: [view: TiltifyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tiltify.PubSub,
  live_view: [signing_salt: "1nLrxKg9"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
