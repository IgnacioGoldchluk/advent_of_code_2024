defmodule AdventOfCode2024 do
  @moduledoc """
  Advent of Code 2024 in Elixir
  """

  @doc """
  Runs a specific day and returns the part1 and part2 results as
  an `AdventOfCode2024.Solution` struct
  """
  @spec run(String.t()) :: AdventOfCode2024.Solution.t()
  def run(day) do
    # Dynamically fetch the module name and execute the solve/1 function
    String.to_existing_atom("Elixir.AdventOfCode2024.Day#{day}")
    |> apply(:solve, [File.read!("inputs/day#{day}")])
  end
end
