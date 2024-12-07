defmodule AdventOfCode2024.Day7Test do
  use ExUnit.Case

  alias AdventOfCode2024.Day7
  alias AdventOfCode2024.Solution

  test "solve/1" do
    input = """
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20\
    """

    assert %Solution{part1: 3749, part2: 11387} == Day7.solve(input)
  end
end
