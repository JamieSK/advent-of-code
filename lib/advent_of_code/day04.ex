defmodule AdventOfCode.Day04 do
  use AdventOfCode

  @moduledoc """
  #{ readme("resources/day04/README.md") }
  """

  @impl true
  def run do
    input = File.stream!("resources/day04/input.txt")

    IO.puts("--- Part One ---")
    IO.puts("Result: #{part_one(input)}")

    IO.puts("--- Part Two ---")
    IO.puts("Result: #{part_two(input)}")
  end

  def part_one(args) do
    args
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn line ->
      Regex.run(~r/(\d*)\-(\d*)\,(\d*)\-(\d*)/, line, capture: :all_but_first)
    end)
    |> Stream.map(fn list -> Enum.map(list, &String.to_integer/1) end)
    |> Enum.count(fn [low1, high1, low2, high2] -> (low1 <= low2 and high1 >= high2) or (low2 <= low1 and high2 >= high1) end)
  end

  def part_two(args) do
    args
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn line ->
      Regex.run(~r/(\d*)\-(\d*)\,(\d*)\-(\d*)/, line, capture: :all_but_first)
    end)
    |> Stream.map(fn list -> Enum.map(list, &String.to_integer/1) end)
    |> Enum.count(fn [low1, high1, low2, high2] -> !Range.disjoint?(low1..high1, low2..high2) end)
  end
end
