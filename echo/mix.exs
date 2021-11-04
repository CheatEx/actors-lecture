defmodule Echo.MixProject do
  use Mix.Project

  def project do
    [
      app: :echo,
      version: "0.1.0",
      elixir: "~> 1.12",
      config_path: "./config/config.exs",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :sasl],
      mod: {Echo.Application, []}
    ]
  end

  defp deps do
    []
  end
end
