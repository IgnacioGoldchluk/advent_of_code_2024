defmodule AdventOfCode2024.Day9 do
  @behaviour AdventOfCode2024.Solution

  def solve(input) do
    %AdventOfCode2024.Solution{part1: part1(input), part2: nil}
  end

  defp part1(input) do
    layout = parse(input)

    empty = Enum.with_index(layout) |> Enum.filter(&is_nil(elem(&1, 0))) |> Enum.map(&elem(&1, 1))

    {moved, same} =
      layout
      |> Enum.with_index()
      |> Enum.reverse()
      |> Enum.reject(fn {val, _idx} -> is_nil(val) end)
      |> Enum.split(length(empty))

    count_moved =
      Enum.zip(moved, empty)
      |> Enum.map(fn {{val, idx}, shifted_idx} -> val * min(idx, shifted_idx) end)
      |> Enum.sum()

    count_unchanged = Enum.map(same, fn {val, idx} -> val * idx end) |> Enum.sum()

    count_moved + count_unchanged
  end

  defp parse(input),
    do: input |> String.graphemes() |> Enum.map(&String.to_integer/1) |> parse(:files, {[], 0})

  defp parse([], _, {mem, _}), do: Enum.reverse(mem)

  defp parse([qty | rest], :files, {mem, file_id}),
    do: parse(rest, :empty, {List.duplicate(file_id, qty) ++ mem, file_id + 1})

  defp parse([qty | rest], :empty, {mem, file_id}),
    do: parse(rest, :files, {List.duplicate(nil, qty) ++ mem, file_id})
end
