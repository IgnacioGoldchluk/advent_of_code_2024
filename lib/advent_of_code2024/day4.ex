defmodule AdventOfCode2024.Day4 do
  @behaviour AdventOfCode2024.Solution

  @impl AdventOfCode2024.Solution
  def solve(input) do
    matrix = to_matrix_map(input)
    %AdventOfCode2024.Solution{part1: part1(matrix), part2: part2(matrix)}
  end

  def to_matrix_map(input) do
    for {line, i} <- Enum.with_index(String.split(input, "\n")),
        {char, j} <- Enum.with_index(to_charlist(line)),
        into: Map.new(),
        do: {{i, j}, char}
  end

  defp part1(matrix), do: Map.keys(matrix) |> Enum.map(&xmas_count(&1, matrix)) |> Enum.sum()

  defp part2(matrix), do: matrix |> Enum.count(&forms_xmas?(&1, matrix))

  defp left({i, j}), do: {i, j - 1}
  defp right({i, j}), do: {i, j + 1}
  defp up({i, j}), do: {i - 1, j}
  defp down({i, j}), do: {i + 1, j}
  defp up_left(point), do: point |> up() |> left()
  defp up_right(point), do: point |> up() |> right()
  defp down_left(point), do: point |> down() |> left()
  defp down_right(point), do: point |> down() |> right()

  defp xmas_count(start, matrix) do
    [&left/1, &right/1, &up/1, &down/1, &up_left/1, &up_right/1, &down_left/1, &down_right/1]
    |> Enum.count(fn dir -> forms_word?(start, ~c"XMAS", matrix, dir) end)
  end

  defp forms_word?(_point, [], _, _), do: true

  defp forms_word?(point, [l | rest], matrix, dir) do
    case matrix[point] do
      ^l -> forms_word?(dir.(point), rest, matrix, dir)
      _ -> false
    end
  end

  defp forms_xmas?({p, ?A}, matrix) do
    diag_1 = [matrix[up_left(p)], matrix[down_right(p)]]
    diag_2 = [matrix[up_right(p)], matrix[down_left(p)]]

    targets = [~c"MS", ~c"SM"]
    diag_1 in targets and diag_2 in targets
  end

  defp forms_xmas?({_point, _not_a}, _matrix), do: false
end
