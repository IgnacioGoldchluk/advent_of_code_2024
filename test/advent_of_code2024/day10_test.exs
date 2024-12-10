defmodule AdventOfCode2024.Day10Test do
  use ExUnit.Case

  alias AdventOfCode2024.Day10
  alias AdventOfCode2024.Solution

  test "solve/1" do
    input = """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732\
    """

    assert %Solution{part1: 36, part2: 81} == Day10.solve(input)
  end
end
