defmodule AdventOfCode2024 do
  @moduledoc """
  Advent of Code 2024 in Elixir
  """

  def run(day) do
    input = File.read!("inputs/day#{day}")

    solution =
      case String.to_integer(day) do
        1 -> AdventOfCode2024.Day1.solve(input)
      end

    IO.inspect(solution)
  end
end
