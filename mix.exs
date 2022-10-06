defmodule HealthcheckCloud.MixProject do
  use Mix.Project

  def project do
    [
      app: :healthcheck_cloud,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HealthcheckCloud.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:floki, "~> 0.33.0"},
      {:html5ever, "~> 0.13.0"},
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17"},
      {:jason, ">= 1.0.0"},
      {:plug_cowboy, "~> 2.5"}
    ]
  end
end
