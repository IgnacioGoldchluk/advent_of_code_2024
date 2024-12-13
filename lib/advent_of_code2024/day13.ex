defmodule AdventOfCode2024.Day13 do
  @behaviour AdventOfCode2024.Solution

  def solve(input) do
    behaviours = parse(input)
    %AdventOfCode2024.Solution{part1: part1(behaviours), part2: part2(behaviours)}
  end

  defp part1(behaviours) do
    behaviours
    |> Enum.map(&to_solution/1)
    |> Enum.map(fn {a, b} -> a * 3 + b end)
    |> Enum.sum()
  end

  defp part2(behaviours) do
    behaviours
    |> Enum.map(&add_offset/1)
    |> Enum.map(&to_solution/1)
    |> Enum.map(fn {a, b} -> a * 3 + b end)
    |> Enum.sum()
  end

  defp parse(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, "\n"))
    |> Enum.map(&to_behaviour_prize/1)
  end

  defp re_a, do: ~r/Button A: X\+(\d+), Y\+(\d+)/
  defp re_b, do: ~r/Button B: X\+(\d+), Y\+(\d+)/
  defp re_prize, do: ~r/Prize: X=(\d+), Y=(\d+)/

  defp to_behaviour_prize([a, b, prize]) do
    a = Regex.run(re_a(), a, capture: :all_but_first) |> Enum.map(&String.to_integer/1)
    b = Regex.run(re_b(), b, capture: :all_but_first) |> Enum.map(&String.to_integer/1)
    p = Regex.run(re_prize(), prize, capture: :all_but_first) |> Enum.map(&String.to_integer/1)

    {a, b, p}
  end

  defp to_solution({[a_x, a_y], [b_x, b_y], [x, y]}) do
    # 2x2 matrix
    # a_x * a + b_x * b = x
    # a_y * a + b_y + b = y
    # where a is the button presses of A, and b is the button presses of B
    case a_x * b_y - b_x * a_y do
      0 ->
        # Linearly dependent functions, no solution
        {0, 0}

      det ->
        num_x = x * b_y - y * b_x
        num_y = y * a_x - x * a_y

        # Integer solutions only
        if rem(num_x, det) == 0 and rem(num_y, det) == 0 do
          {div(num_x, det), div(num_y, det)}
        else
          {0, 0}
        end
    end
  end

  defp offset, do: 10_000_000_000_000
  defp add_offset({a, b, [x, y]}), do: {a, b, [x + offset(), y + offset()]}
end
