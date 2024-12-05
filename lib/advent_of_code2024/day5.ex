defmodule AdventOfCode2024.Day5 do
  @behaviour AdventOfCode2024.Solution

  @impl AdventOfCode2024.Solution
  def solve(input) do
    [rules, sequences] = String.split(input, "\n\n")
    sequences = parse_sequences(sequences)
    %AdventOfCode2024.Solution{part1: part1(rules, sequences), part2: part2(rules, sequences)}
  end

  defp part1(rules, sequences) do
    sequences
    |> Enum.filter(&valid?(Enum.reverse(&1), parse_rules_map(rules)))
    |> Enum.map(&middle_point/1)
    |> Enum.sum()
  end

  defp part2(rules, sequences) do
    sequences
    |> Enum.reject(&valid?(Enum.reverse(&1), parse_rules_map(rules)))
    |> Enum.map(&order(&1, parse_rules_mapset(rules)))
    |> Enum.map(&middle_point/1)
    |> Enum.sum()
  end

  defp valid?([_x], _rules), do: true

  defp valid?([x | rest], rules) do
    cond do
      not MapSet.disjoint?(MapSet.new(rest), Map.get(rules, x, MapSet.new())) -> false
      true -> valid?(rest, rules)
    end
  end

  defp middle_point(numbers), do: Enum.at(numbers, numbers |> length() |> div(2))

  defp parse_rules_map(rules) do
    rules
    |> String.split("\n")
    |> Enum.reduce(Map.new(), fn line, acc ->
      [bef, aft] = String.split(line, "|") |> Enum.map(&String.to_integer/1)
      Map.update(acc, bef, MapSet.new([aft]), fn afts -> MapSet.put(afts, aft) end)
    end)
  end

  defp parse_rules_mapset(rules) do
    # This only works because every pair is defined
    rules
    |> String.split("\n")
    |> MapSet.new(fn line ->
      String.split(line, "|") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
    end)
  end

  defp order(seq, rules), do: Enum.sort(seq, fn l, r -> MapSet.member?(rules, {l, r}) end)

  defp parse_sequences(seqs) do
    seqs
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line, ",") |> Enum.map(&String.to_integer/1) end)
  end
end
