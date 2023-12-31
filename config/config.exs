# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :rolling_bites,
  ecto_repos: [RollingBites.Repo]

# Configures the endpoint
config :rolling_bites, RollingBitesWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: RollingBitesWeb.ErrorHTML, json: RollingBitesWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: RollingBites.PubSub,
  live_view: [signing_salt: "ZT6DsYo3"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :rolling_bites, RollingBites.Mailer, adapter: Swoosh.Adapters.Local

config :rolling_bites, :ipgeolocation_api_key, System.get_env("IPGEOLOCATION_API_KEY")

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  handle_otp_reports: true,
  handle_sasl_reports: true

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :rolling_bites,
  soda_api_key: System.get_env("SODA_API_KEY"),
  soda_url: System.get_env("SODA_URL")
