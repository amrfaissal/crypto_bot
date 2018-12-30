defmodule CryptoBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :crypto_bot,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CryptoBot.Application, []}
    ]
  end

  defp deps do
    [
      {:slack, "~> 0.14.0"},
      {:httpotion, "~> 3.1"}
    ]
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md LICENSE VERSION),
      maintainers: ["Faissal Elamraoui"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/amrfaissal/crypto_bot.git"}
    ]
  end
end
