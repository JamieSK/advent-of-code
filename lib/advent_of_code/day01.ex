defmodule AdventOfCode.Day01 do
  use AdventOfCode

  @moduledoc """
  #{ readme("resources/day01/README.md") }
  """

  @impl true
  def run do
    input = File.stream!("resources/day01/input.txt")

    IO.puts("--- Part One ---")
    IO.puts("Result: #{part_one(input)}")

    IO.puts("--- Part Two ---")
    IO.puts("Result: #{part_two(input)}")
  end

  def part_one(args) do
      args
      |> Enum.reduce({0, 0}, fn line, {current_max, running_total} ->
      line
      |> String.trim()
      |> case do
        "" -> {max(current_max, running_total), 0}
        str -> {current_max, running_total + String.to_integer(str)}
      end
    end)
    |> elem(0)
  end

  def part_two(args) do
    args
    |> Enum.reduce({[0, 0, 0], 0}, fn line, {current_maxes, running_total} ->
      line
      |> String.trim()
      |> case do
        "" ->
          {
            [running_total | current_maxes]
            |> Enum.sort(&(&1 >= &2))
            |> Enum.drop(-1),
            0
          }
        str -> {current_maxes, running_total + String.to_integer(str)}
      end
    end)
    |> elem(0)
    |> Enum.sum()
  end
end
