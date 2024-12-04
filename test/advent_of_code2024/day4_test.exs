defmodule AdventOfCode2024.Day4Test do
  use ExUnit.Case
  alias AdventOfCode2024.Day4
  alias AdventOfCode2024.Solution

  test "solve/1" do
    input = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX\
    """

    assert %Solution{part1: 18, part2: 9} == Day4.solve(input)
  end
end
