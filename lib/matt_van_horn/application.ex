defmodule MattVanHorn.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MattVanHornWeb.Telemetry,
      MattVanHorn.Repo,
      {DNSCluster, query: Application.get_env(:matt_van_horn, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MattVanHorn.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MattVanHorn.Finch},
      # Start a worker by calling: MattVanHorn.Worker.start_link(arg)
      # {MattVanHorn.Worker, arg},
      # Start to serve requests, typically the last entry
      MattVanHornWeb.Endpoint,
      {AshAuthentication.Supervisor, [otp_app: :matt_van_horn]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MattVanHorn.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MattVanHornWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
