defmodule HealthcheckCloud.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy,
       scheme: :http,
       plug: HealthcheckCloud.Router,
       options: [port: Application.get_env(:healthcheck_cloud, :port)]},
       HealthcheckCloud.GenServer
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HealthcheckCloud.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
