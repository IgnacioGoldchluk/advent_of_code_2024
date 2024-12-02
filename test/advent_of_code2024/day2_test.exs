defmodule AdventOfCode2024.Day2Test do
  use ExUnit.Case
  alias AdventOfCode2024.Day2
  alias AdventOfCode2024.Solution

  test "solve/1" do
    input = """
        7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9\
    """

    assert %Solution{part1: 2, part2: 4} == Day2.solve(input)
  end
end
