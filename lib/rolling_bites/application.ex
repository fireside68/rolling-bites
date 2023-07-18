defmodule RollingBites.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    unless Mix.env() == :prod do
      Dotenv.load()
      Mix.Task.run("loadconfig")
    end

    children = [
      # Start the Telemetry supervisor
      RollingBitesWeb.Telemetry,
      # Start the Ecto repository
      RollingBites.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: RollingBites.PubSub},
      # Start Finch
      {Finch, name: RollingBites.Finch},
      # Start the Endpoint (http/https)
      RollingBitesWeb.Endpoint,
      # Start a worker by calling: RollingBites.Worker.start_link(arg)
      # {RollingBites.Worker, arg}
      # Start worker to rerieve user location from IP
      RollingBites.IPFetchServer,
      # Start worker to retrieve data from SODA API
      RollingBites.SodaAPIServer
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RollingBites.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RollingBitesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
