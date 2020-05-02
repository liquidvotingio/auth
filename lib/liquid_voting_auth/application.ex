defmodule LiquidVotingAuth.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # ECTO IS DISABLED UNTIL WE NEED IT
      # Start the Ecto repository
      # LiquidVotingAuth.Repo,
      # Start the Telemetry supervisor
      LiquidVotingAuthWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiquidVotingAuth.PubSub},
      # Start the Endpoint (http/https)
      LiquidVotingAuthWeb.Endpoint
      # Start a worker by calling: LiquidVotingAuth.Worker.start_link(arg)
      # {LiquidVotingAuth.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiquidVotingAuth.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LiquidVotingAuthWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
