defmodule AdventOfCode2024.Day1Test do
  use ExUnit.Case
  alias AdventOfCode2024.Day1

  test "solve/1" do
    input = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """

    assert %AdventOfCode2024.Solution{part1: 11, part2: 31} == Day1.solve(input)
  end
end
