defmodule AdventOfCode2024.Day3 do
  @behaviour AdventOfCode2024.Solution

  @impl AdventOfCode2024.Solution
  def solve(input) do
    %AdventOfCode2024.Solution{part1: part1(input), part2: part2(input)}
  end

  defp pattern, do: ~r/mul\((\d{1,3}),(\d{1,3})\)/
  defp pattern2, do: ~r/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/

  defp part1(input) do
    Regex.scan(pattern(), input, capture: :all_but_first) |> Enum.map(&mul/1) |> Enum.sum()
  end

  defp part2(input) do
    Regex.scan(pattern2(), input, capture: :first) |> Enum.flat_map(& &1) |> mul2(:enabled, 0)
  end

  defp mul2([], _, acc), do: acc
  defp mul2(["mul" <> _ | rest], :disabled, acc), do: mul2(rest, :disabled, acc)
  defp mul2(["do()" | rest], _, acc), do: mul2(rest, :enabled, acc)
  defp mul2(["don't()" | rest], _, acc), do: mul2(rest, :disabled, acc)
  defp mul2(["mul" <> vals | rest], :enabled, acc), do: mul2(rest, :enabled, acc + mul(vals))

  def mul(vals) when is_binary(vals) do
    [x1, x2] = Regex.run(~r/\((\d{1,3}),(\d{1,3})\)/, vals, capture: :all_but_first)
    String.to_integer(x1) * String.to_integer(x2)
  end

  def mul([num1, num2]), do: String.to_integer(num1) * String.to_integer(num2)
end
