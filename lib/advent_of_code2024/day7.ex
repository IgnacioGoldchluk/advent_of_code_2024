defmodule AdventOfCode2024.Day7 do
  @behaviour AdventOfCode2024.Solution

  @impl AdventOfCode2024.Solution
  def solve(input) do
    parsed = parse(input)
    %AdventOfCode2024.Solution{part1: part1(parsed), part2: part2(parsed)}
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      [total, nums] = String.split(line, ":")
      {String.to_integer(total), Enum.map(String.split(nums), &String.to_integer/1)}
    end)
  end

  defp concat(l, r), do: String.to_integer("#{r}#{l}")

  defp part1(eqs), do: sum_solvable(eqs, [&Kernel.*/2, &Kernel.+/2])
  defp part2(eqs), do: sum_solvable(eqs, [&Kernel.*/2, &Kernel.+/2, &concat/2])

  defp sum_solvable(eqs, ops),
    do: Enum.filter(eqs, &solvable?(&1, ops)) |> Enum.map(&elem(&1, 0)) |> Enum.sum()

  defp solvable?({_, []}, _), do: false
  defp solvable?({total, [h | t]}, ops), do: adds?(t, total, h, ops)

  defp adds?(nums, total, acc, ops) do
    cond do
      nums == [] -> total == acc
      acc > total -> false
      true -> Enum.any?(ops, fn op -> adds?(tl(nums), total, op.(hd(nums), acc), ops) end)
    end
  end
end
