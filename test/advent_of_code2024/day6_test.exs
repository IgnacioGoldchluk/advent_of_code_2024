defmodule AdventOfCode2024.Day6Test do
  use ExUnit.Case

  alias AdventOfCode2024.Day6
  alias AdventOfCode2024.Solution

  test "solve/1" do
    input = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...\
    """

    assert %Solution{part1: 41, part2: 6} == Day6.solve(input)
  end
end
