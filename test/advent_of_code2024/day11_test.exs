defmodule AdventOfCode2024.Day11Test do
  use ExUnit.Case

  alias AdventOfCode2024.Day11
  alias AdventOfCode2024.Solution

  test "solve/1" do
    input = "125 17"

    assert %Solution{part1: 55312, part2: 65_601_038_650_482} == Day11.solve(input)
  end
end
