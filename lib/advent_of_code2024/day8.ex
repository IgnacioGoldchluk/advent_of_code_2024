defmodule AdventOfCode2024.Day8 do
  @behaviour AdventOfCode2024.Solution

  @impl AdventOfCode2024.Solution
  def solve(input) do
    {grid, limits} = parse(input)
    %AdventOfCode2024.Solution{part1: part1({grid, limits}), part2: part2({grid, limits})}
  end

  defp parse(input) do
    grid =
      for {row, i} <- Enum.with_index(String.split(input, "\n")),
          {char, j} <- Enum.with_index(to_charlist(row)),
          into: %{},
          do: {{i, j}, char}

    {Map.filter(grid, fn {_k, v} -> v != ?. end), Map.keys(grid) |> Enum.max()}
  end

  defp within_limits?({x, y}, {max_x, max_y}), do: x >= 0 and x <= max_x and y >= 0 and y <= max_y

  defp antinodes(antennas, limits) when is_list(antennas) do
    combinations = for x <- antennas, y <- antennas, x != y, do: {x, y}
    Enum.flat_map(combinations, fn {a1, a2} -> antinodes(a1, a2, limits) end)
  end

  defp antinodes({x1, y1}, {x2, y2}, limits) do
    dx = x1 - x2
    dy = y1 - y2

    Enum.filter([{x1 + dx, y1 + dy}, {x2 - dx, y2 - dy}], &within_limits?(&1, limits))
  end

  defp antinodes2(antennas, limits) when is_list(antennas) do
    combinations = for x <- antennas, y <- antennas, x != y, do: {x, y}
    Enum.flat_map(combinations, fn {a1, a2} -> antinodes2(a1, a2, limits) end)
  end

  defp antinodes2({x1, y1} = p1, {x2, y2}, limits) do
    {mx_pre, my_pre} = {x1 - x2, y1 - y2}
    gcd = Integer.gcd(mx_pre, my_pre)
    {mx, my} = {div(mx_pre, gcd), div(my_pre, gcd)}

    up_fn = fn {x, y} -> {x + mx, y + my} end
    dn_fn = fn {x, y} -> {x - mx, y - my} end

    [up_fn, dn_fn]
    |> Enum.flat_map(&line(p1, limits, [], &1))
    |> Enum.filter(&within_limits?(&1, limits))
  end

  defp line({x, y}, {max_x, max_y}, acc, _) when x < 0 or y < 0 or x > max_x or y > max_y, do: acc
  defp line(p, limits, acc, next), do: line(next.(p), limits, [p | acc], next)

  defp unique_antinodes({grid, limits}, antinodes_fn) do
    grid
    |> Enum.group_by(&elem(&1, 1), &elem(&1, 0))
    |> Enum.flat_map(fn {_k, antennas} -> antinodes_fn.(antennas, limits) end)
    |> MapSet.new()
    |> MapSet.size()
  end

  defp part2({grid, limits}), do: unique_antinodes({grid, limits}, &antinodes2/2)
  defp part1({grid, limits}), do: unique_antinodes({grid, limits}, &antinodes/2)
end
