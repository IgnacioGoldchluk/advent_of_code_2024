defmodule AdventOfCode2024.Day2 do
  @behaviour AdventOfCode2024.Solution

  def solve(input) do
    parsed_input = parse(input)
    %AdventOfCode2024.Solution{part1: part1(parsed_input), part2: part2(parsed_input)}
  end

  defp part1(lines), do: lines |> Enum.filter(&safe?/1) |> Enum.count()

  defp part2(lines), do: lines |> Enum.filter(&safe_with_dels?/1) |> Enum.count()

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line) |> Enum.map(&String.to_integer/1) end)
  end

  defp safe?(numbers) do
    d = differences(numbers)
    Enum.all?(d, &Enum.member?([1, 2, 3], &1)) or Enum.all?(d, &Enum.member?([-1, -2, -3], &1))
  end

  defp differences([_ | t] = nums), do: nums |> Enum.zip(t) |> Enum.map(fn {f, s} -> s - f end)

  defp safe_with_dels?(nums), do: [nums] |> Enum.concat(deletions(nums)) |> Enum.any?(&safe?/1)

  defp deletions(nums), do: Enum.map(0..(length(nums) - 1), &List.delete_at(nums, &1))
end
