defmodule AdventOfCode2024.Solution do
  defstruct [:part1, :part2]

  @type t :: %__MODULE__{}

  @callback solve(String.t()) :: t()
end
