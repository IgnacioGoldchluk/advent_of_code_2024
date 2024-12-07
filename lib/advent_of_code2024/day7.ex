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

  defp part1_ops, do: [&Kernel.*/2, &Kernel.+/2]
  defp part2_ops, do: [&Kernel.*/2, &Kernel.+/2, &concat/2]

  defp part1(eqs), do: sum_solvable(eqs, part1_ops())
  defp part2(eqs), do: sum_solvable(eqs, part2_ops())

  defp sum_solvable(eqs, ops),
    do: Enum.filter(eqs, &solvable?(&1, ops)) |> Enum.map(&elem(&1, 0)) |> Enum.sum()

  defp solvable?({_, []}, _), do: false
  defp solvable?({total, [h | t]}, ops), do: adds?(t, total, h, ops)

  defp adds?(n, total, acc, ops) do
    cond do
      n == [] ->
        total == acc

      acc > total ->
        false

      true ->
        [h | t] = n
        Enum.any?(ops, fn op -> adds?(t, total, op.(h, acc), ops) end)
    end
  end
end
