defmodule AdventOfCode.Day03 do
  use AdventOfCode

  @moduledoc """
  #{ readme("resources/day03/README.md") }
  """

  @impl true
  def run do
    input = File.stream!("resources/day03/input.txt")

    IO.puts("--- Part One ---")
    IO.puts("Result: #{part_one(input)}")

    IO.puts("--- Part Two ---")
    IO.puts("Result: #{part_two(input)}")
  end

  def part_one(args) do
    args
    |> Enum.reduce(0, fn line, running_total ->
      halves = line
      |> String.trim()
      |> String.split_at(div(String.length(line), 2))
      |> Tuple.to_list()
      |> Enum.map(&String.graphemes/1)

      List.first(halves)
      |> Enum.reject(fn x -> !Enum.member?(List.last(halves), x) end)
      |> List.first()
      |> case do
        nil -> 0
        letter ->
          letter
          |> String.to_charlist()
          |> List.first()
          |> case do
            l when l in ?a..?z -> l - 96
            l when l in ?A..?Z -> l - 38
          end
      end
      |> Kernel.+(running_total)
    end)
  end

  def part_two(args) do
    args
    |> Stream.map(fn line ->
      line
      |> String.trim()
      |> String.to_charlist()
      |> MapSet.new()
    end)
    |> Stream.chunk_every(3, 3, :discard)
    |> Enum.reduce(0, fn [ms1, ms2, ms3], running_total ->
      ms1
      |> MapSet.intersection(ms2)
      |> MapSet.intersection(ms3)
      |> MapSet.to_list()
      |> List.first()
      |> case do
        nil -> 0
        codepoint ->
          codepoint
          |> case do
            l when l in ?a..?z -> l - 96
            l when l in ?A..?Z -> l - 38
          end
      end
      |> Kernel.+(running_total)
    end)
  end
end
