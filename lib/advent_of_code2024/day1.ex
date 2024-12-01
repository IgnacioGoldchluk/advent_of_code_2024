defmodule AdventOfCode2024.Day1 do
  @behaviour AdventOfCode2024.Solution

  def solve(input) do
    parsed_input = parse(input)

    %AdventOfCode2024.Solution{
      part1: part1(parsed_input),
      part2: part2(parsed_input)
    }
  end

  @spec parse(String.t()) :: {list(integer()), list(integer())}
  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ~r/\s+/))
    |> Enum.reduce({[], []}, fn [num1, num2], {acc1, acc2} ->
      {[String.to_integer(num1) | acc1], [String.to_integer(num2) | acc2]}
    end)
  end

  defp part2({col1, col2}) do
    count = Enum.frequencies(col2)

    col1
    |> Enum.map(fn num -> num * Map.get(count, num, 0) end)
    |> Enum.sum()
  end

  defp part1({col1, col2}) do
    [Enum.sort(col1), Enum.sort(col2)]
    |> Enum.zip_reduce(0, fn [num1, num2], acc ->
      acc + abs(num2 - num1)
    end)
  end
end
