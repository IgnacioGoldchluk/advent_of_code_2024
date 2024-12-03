defmodule AdventOfCode2024.Day3Test do
  use ExUnit.Case
  alias AdventOfCode2024.Day3
  alias AdventOfCode2024.Solution

  test "solve/1" do
    input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

    assert %Solution{part1: 161, part2: 48} == Day3.solve(input)
  end
end
