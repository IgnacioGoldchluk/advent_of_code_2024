defmodule AdventOfCode2024.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code_2024,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      elixirc_options: [warnings_as_errors: true],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps, do: []
end
