defmodule AdventOfCode2024.Day6 do
  @behaviour AdventOfCode2024.Solution

  @impl AdventOfCode2024.Solution
  def solve(input) do
    parsed = parse(input)
    %AdventOfCode2024.Solution{part1: part1(parsed), part2: part2(parsed)}
  end

  defp parse(input) do
    grid =
      for {row, i} <- Enum.with_index(String.split(input, "\n")),
          {char, j} <- Enum.with_index(to_charlist(row)),
          into: Map.new(),
          do: {{i, j}, char}

    rows = Map.keys(grid) |> Enum.map(&elem(&1, 0)) |> Enum.max()
    cols = Map.keys(grid) |> Enum.map(&elem(&1, 1)) |> Enum.max()
    size = {rows, cols}

    start = grid |> Enum.find(grid, fn {_coord, char} -> char == ?^ end) |> elem(0)
    blocks = Map.filter(grid, fn {_coord, val} -> val == ?# end) |> Map.keys()

    {start, {blocks, size}}
  end

  defp turn(:up), do: :right
  defp turn(:right), do: :down
  defp turn(:down), do: :left
  defp turn(:left), do: :up

  defp hit_point({x, y}, :up, blocks) do
    case Enum.filter(blocks, fn {bx, by} -> bx < x and by == y end) do
      [] -> nil
      others -> Enum.max_by(others, &elem(&1, 0)) |> then(fn {bx, by} -> {bx + 1, by} end)
    end
  end

  defp hit_point({x, y}, :down, blocks) do
    case Enum.filter(blocks, fn {bx, by} -> bx > x and by == y end) do
      [] -> nil
      others -> Enum.min_by(others, &elem(&1, 0)) |> then(fn {bx, by} -> {bx - 1, by} end)
    end
  end

  defp hit_point({x, y}, :left, blocks) do
    case Enum.filter(blocks, fn {bx, by} -> bx == x and by < y end) do
      [] -> nil
      others -> Enum.max_by(others, &elem(&1, 1)) |> then(fn {bx, by} -> {bx, by + 1} end)
    end
  end

  defp hit_point({x, y}, :right, blocks) do
    case Enum.filter(blocks, fn {bx, by} -> bx == x and by > y end) do
      [] -> nil
      others -> Enum.min_by(others, &elem(&1, 1)) |> then(fn {bx, by} -> {bx, by - 1} end)
    end
  end

  defp walked({x1, y}, :up, {x2, y}), do: Enum.map(x2..x1, &{&1, y})
  defp walked({x1, y}, :down, {x2, y}), do: Enum.map(x1..x2, &{&1, y})
  defp walked({x, y1}, :left, {x, y2}), do: Enum.map(y1..y2, &{x, &1})
  defp walked({x, y1}, :right, {x, y2}), do: Enum.map(y2..y1, &{x, &1})

  defp walk(point, dir, hit), do: MapSet.new(walked(point, dir, hit))

  defp limit({_, y}, :up, _), do: {0, y}
  defp limit({_, y}, :down, {max_x, _}), do: {max_x, y}
  defp limit({x, _}, :left, _), do: {x, 0}
  defp limit({x, _}, :right, {_, max_y}), do: {x, max_y}

  defp move(point, dir, seen, {blocks, size} = grid) do
    case hit_point(point, dir, blocks) do
      nil -> MapSet.union(seen, walk(point, dir, limit(point, dir, size)))
      new -> move(new, turn(dir), MapSet.union(seen, walk(point, dir, new)), grid)
    end
  end

  defp loops?(point, dir, seen, blocks) do
    hit_point = hit_point(point, dir, blocks)

    cond do
      MapSet.member?(seen, {dir, point}) -> true
      is_nil(hit_point) -> false
      true -> loops?(hit_point, turn(dir), MapSet.put(seen, {dir, point}), blocks)
    end
  end

  defp part1({start, {grid, size}}), do: Enum.count(move(start, :up, MapSet.new(), {grid, size}))

  defp part2({start, {grid, {max_x, max_y}}}) do
    grids =
      for x <- 0..max_x,
          y <- 0..max_y,
          {x, y} != start and not Enum.member?(grid, {x, y}) do
        [{x, y} | grid]
      end

    Enum.count(grids, fn grid -> loops?(start, :up, MapSet.new(), grid) end)
  end
end
