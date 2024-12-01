defmodule Mix.Tasks.Solve do
  @moduledoc """
  Runs an outputs the solution for a given day
  """
  use Mix.Task

  @impl Mix.Task
  def run([day]) do
    day
    |> AdventOfCode2024.run()
    |> IO.inspect()
  end
end
