defmodule AdventOfCode.Day02 do
  use AdventOfCode

  @moduledoc """
  #{ readme("resources/day02/README.md") }
  """

  @impl true
  def run do
    input = File.stream!("resources/day02/input.txt")

    IO.puts("--- Part One ---")
    IO.puts("Result: #{part_one(input)}")

    IO.puts("--- Part Two ---")
    IO.puts("Result: #{part_two(input)}")
  end

  def part_one(args) do
    args
    |> Enum.reduce(0, fn line, running_total ->
      running_total + case line |> String.trim() do
        "A X" -> 4
        "A Y" -> 8
        "A Z" -> 3
        "B X" -> 1
        "B Y" -> 5
        "B Z" -> 9
        "C X" -> 7
        "C Y" -> 2
        "C Z" -> 6
        _ -> 0
      end
    end)
  end

  def part_two(args) do
    args
    |> Enum.reduce(0, fn line, running_total ->
      running_total + case line |> String.trim() do
        "A X" -> 3 + 0
        "A Y" -> 1 + 3
        "A Z" -> 2 + 6
        "B X" -> 1 + 0
        "B Y" -> 2 + 3
        "B Z" -> 3 + 6
        "C X" -> 2 + 0
        "C Y" -> 3 + 3
        "C Z" -> 1 + 6
        _ -> 0
      end
    end)
  end
end
