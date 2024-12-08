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

    limits = grid |> Map.keys() |> Enum.max()

    {Map.filter(grid, fn {_k, v} -> v != ?. end), limits}
  end

  defp within_limits?({x, y}, {max_x, max_y}), do: x >= 0 and x <= max_x and y >= 0 and y <= max_y

  defp antinodes(antennas, limits) when is_list(antennas) do
    combinations = for x <- antennas, y <- antennas, x != y, do: {x, y}

    Enum.flat_map(combinations, fn {a1, a2} -> antinodes(a1, a2, limits) end)
  end

  defp antinodes({x1, y1}, {x2, y2}, limits) do
    dx = x1 - x2
    dy = y1 - y2

    [{x1 + dx, y1 + dy}, {x2 - dx, y2 - dy}]
    |> Enum.filter(&within_limits?(&1, limits))
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

    up = all_points(p1, limits, [], up_fn)
    dn = all_points(p1, limits, [], dn_fn)

    Enum.concat(up, dn) |> Enum.filter(&within_limits?(&1, limits))
  end

  defp all_points({x, y} = p, {max_x, max_y} = limits, acc, next_fn) do
    cond do
      x < 0 or x > max_x or y < 0 or y > max_y -> acc
      true -> all_points(next_fn.(p), limits, [p | acc], next_fn)
    end
  end

  defp part2({grid, limits}) do
    grid
    |> Enum.group_by(&elem(&1, 1), &elem(&1, 0))
    |> Enum.flat_map(fn {_k, antennas} -> antinodes2(antennas, limits) end)
    |> MapSet.new()
    |> MapSet.size()
  end

  defp part1({grid, limits}) do
    grid
    |> Enum.group_by(&elem(&1, 1), &elem(&1, 0))
    |> Enum.flat_map(fn {_k, antennas} -> antinodes(antennas, limits) end)
    |> MapSet.new()
    |> MapSet.size()
  end
end
