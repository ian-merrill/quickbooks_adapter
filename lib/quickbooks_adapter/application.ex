defmodule QuickbooksAdapter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      QuickbooksAdapter.Repo,
      # Start the Telemetry supervisor
      QuickbooksAdapterWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: QuickbooksAdapter.PubSub},
      # Start the Endpoint (http/https)
      QuickbooksAdapterWeb.Endpoint
      # Start a worker by calling: QuickbooksAdapter.Worker.start_link(arg)
      # {QuickbooksAdapter.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QuickbooksAdapter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    QuickbooksAdapterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
