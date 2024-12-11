defmodule AdventOfCode2024.Day11 do
  @behaviour AdventOfCode2024.Solution

  def solve(input) do
    %AdventOfCode2024.Solution{
      part1: sum_after_blinks(input, 25),
      part2: sum_after_blinks(input, 75)
    }
  end

  defp sum_after_blinks(input, blinks) do
    input
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies()
    |> blink(blinks)
  end

  defp blink(acc, 0), do: acc |> Map.values() |> Enum.sum()

  defp blink(acc, steps_left) do
    Enum.flat_map(acc, fn {stone_n, count} ->
      stone_n |> new_stones() |> Enum.map(&{&1, count})
    end)
    |> Enum.reduce(Map.new(), fn {stone, count}, acc ->
      Map.update(acc, stone, count, fn x -> x + count end)
    end)
    |> blink(steps_left - 1)
  end

  defp new_stones(0), do: [1]

  defp new_stones(num) do
    digits = Integer.digits(num)
    length = length(digits)

    if rem(length, 2) == 0 do
      Enum.split(digits, div(length, 2)) |> Tuple.to_list() |> Enum.map(&Integer.undigits/1)
    else
      [num * 2024]
    end
  end
end
