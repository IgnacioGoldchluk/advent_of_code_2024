defmodule AdventOfCode2024.Day10 do
  @behaviour AdventOfCode2024.Solution

  def solve(input) do
    grid = grid(input)
    %AdventOfCode2024.Solution{part1: part1(grid), part2: part2(grid)}
  end

  defp grid(input) do
    for {row, i} <- Enum.with_index(String.split(input, "\n")),
        {char, j} <- Enum.with_index(String.graphemes(row)),
        into: Map.new(),
        do: {{i, j}, String.to_integer(char)}
  end

  defp part1(grid) do
    grid
    |> Map.filter(fn {_k, v} -> v == 0 end)
    |> Enum.map(fn {pos, 0} -> score([pos], grid, 0) end)
    |> Enum.sum()
  end

  defp part2(grid) do
    grid
    |> Map.filter(fn {_k, v} -> v == 0 end)
    |> Enum.map(fn {pos, 0} -> score2([[pos]], grid, 0) end)
    |> Enum.sum()
  end

  defp neighbors({x, y}, grid, height) do
    [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
    |> Enum.filter(fn neighbor -> Map.get(grid, neighbor) == height + 1 end)
  end

  defp score2([], _, _), do: 0
  defp score2(lists_of_points, _, 9), do: MapSet.new(lists_of_points) |> MapSet.size()

  defp score2(histories, grid, height) do
    Enum.flat_map(histories, fn history ->
      neighbors = neighbors(hd(history), grid, height)
      Enum.map(neighbors, fn neighbor -> [neighbor | history] end)
    end)
    |> score2(grid, height + 1)
  end

  defp score([], _, _), do: 0
  defp score(points, _, 9), do: MapSet.new(points) |> MapSet.size()

  defp score(points, grid, height) do
    points
    |> Enum.flat_map(fn p -> neighbors(p, grid, height) end)
    |> score(grid, height + 1)
  end
end
