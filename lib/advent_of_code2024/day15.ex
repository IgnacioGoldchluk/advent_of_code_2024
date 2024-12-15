defmodule AdventOfCode2024.Day15 do
  alias AdventOfCode2024.Solution

  @behaviour Solution

  def solve(input) do
    # part_2 = part2(parse(input, &twice_as_wide/1))
    %Solution{part1: part1(parse(input)), part2: nil}
  end

  defp parse(input, grid_transform \\ &to_charlist/1) do
    [grid, movements] = String.split(input, "\n\n")
    {parse_grid(grid, grid_transform), to_charlist(movements |> String.replace("\n", ""))}
  end

  defp parse_grid(grid_input, transform) do
    for {row, i} <- Enum.with_index(String.split(grid_input, "\n")),
        {char, j} <- Enum.with_index(transform.(row)),
        into: Map.new(),
        do: {{i, j}, char}
  end

  # defp twice_as_wide(row) do
  #   row
  #   |> String.replace("#", "##")
  #   |> String.replace("O", "[]")
  #   |> String.replace(".", "..")
  #   |> String.replace("@", "@.")
  #   |> to_charlist()
  # end

  defp part1({grid, movements}) do
    grid |> apply_movements(movements) |> gps_values(?O)
  end

  # defp part2({grid, movements}) do
  #   grid |> apply_movements(movements) |> gps_values(?[)
  # end

  defp gps_values(final_grid, edge) do
    final_grid
    |> Map.filter(fn {_pos, val} -> val == edge end)
    |> Map.keys()
    |> Enum.map(fn {x, y} -> x * 100 + y end)
    |> Enum.sum()
  end

  defp robot_pos(grid), do: Enum.find(grid, fn {_pos, val} -> val == ?@ end) |> elem(0)

  defp apply_movements(grid, movements) do
    {_final_pos, final_grid} =
      Enum.reduce(movements, {robot_pos(grid), grid}, fn movement, {pos, grid} ->
        pos |> next_movements(movement, grid) |> move(grid)
      end)

    final_grid
  end

  defp next_pos({x, y}, ?^), do: {x - 1, y}
  defp next_pos({x, y}, ?v), do: {x + 1, y}
  defp next_pos({x, y}, ?<), do: {x, y - 1}
  defp next_pos({x, y}, ?>), do: {x, y + 1}

  defp next_movements(pos, movement, grid), do: moves(pos, movement, grid, [])

  defp moves(pos, movement, grid, changes) do
    next_pos = next_pos(pos, movement)

    case Map.get(grid, next_pos) do
      ?. -> [{pos, next_pos} | changes]
      ?# -> []
      ?O -> moves(next_pos, movement, grid, [{pos, next_pos} | changes])
    end
  end

  defp move([], grid), do: {robot_pos(grid), grid}
  defp move([{src, to}], grid), do: {to, grid |> Map.put(src, ?.) |> Map.put(to, ?@)}
  defp move([{src, to} | rest], grid), do: move(rest, grid |> Map.put(to, ?O) |> Map.put(src, ?.))
end
