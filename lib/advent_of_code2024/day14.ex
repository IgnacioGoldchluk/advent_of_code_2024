defmodule AdventOfCode2024.Day14 do
  @behaviour AdventOfCode2024.Solution

  def solve(input) do
    size = {101, 103}
    robots = parse(input)
    %AdventOfCode2024.Solution{part1: part1(robots, size), part2: part2(robots, size)}
  end

  defp re_robot, do: ~r/p=([-\d]+),([-\d]+) v=([-\d]+),([-\d]+)/

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&to_position_velocity/1)
  end

  defp part1(robots, size) do
    robots
    |> Enum.map(&move_seconds(&1, 100, size))
    |> Enum.map(&elem(&1, 0))
    |> Enum.group_by(&quadrant(&1, size))
    |> Map.delete(nil)
    |> Map.values()
    |> Enum.map(&length/1)
    |> Enum.product()
  end

  defp part2(robots, size) do
    loop_until_tree(robots, size, 0)
  end

  defp loop_until_tree(pos_vel, size, elapsed) do
    positions = MapSet.new(pos_vel, fn {pos, _vel} -> pos end)

    if forms_tree?(positions) do
      elapsed
    else
      pos_vel |> Enum.map(&move_seconds(&1, 1, size)) |> loop_until_tree(size, elapsed + 1)
    end
  end

  defp forms_tree?(positions) do
    # Search (from the top) for the following pattern
    # ..*..
    # .***.
    # *****
    # ..*..
    positions
    |> Enum.any?(fn {x, y} ->
      expected = [
        {x + 1, y - 1},
        {x + 1, y},
        {x + 1, y + 1},
        {x + 2, y - 2},
        {x + 2, y - 1},
        {x + 2, y},
        {x + 2, y + 1},
        {x + 2, y + 2},
        {x + 3, y}
      ]

      Enum.all?(expected, &MapSet.member?(positions, &1))
    end)
  end

  defp to_position_velocity(line) do
    [px, py, vx, vy] =
      Regex.run(re_robot(), line, capture: :all_but_first) |> Enum.map(&String.to_integer/1)

    {{px, py}, {vx, vy}}
  end

  defp move_seconds({{px, py}, {vx, vy}}, seconds, {size_x, size_y}) do
    {{Integer.mod(px + vx * seconds, size_x), Integer.mod(py + vy * seconds, size_y)}, {vx, vy}}
  end

  defp quadrant({pos_x, pos_y}, {size_x, size_y}) do
    half_x = div(size_x, 2)
    half_y = div(size_y, 2)

    cond do
      pos_x == half_x or pos_y == half_y -> nil
      pos_x < half_x and pos_y < half_y -> 1
      pos_x < half_x and pos_y > half_y -> 2
      pos_x > half_x and pos_y < half_y -> 3
      pos_x > half_x and pos_y > half_y -> 4
    end
  end
end
