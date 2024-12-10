defmodule AdventOfCode2024.Day9Test do
  use ExUnit.Case

  alias AdventOfCode2024.Day9
  alias AdventOfCode2024.Solution

  test "solve/1" do
    input = "2333133121414131402"

    assert %Solution{part1: 1928, part2: nil} == Day9.solve(input)
  end
end
