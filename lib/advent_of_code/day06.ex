defmodule AdventOfCode.Day06 do
  use AdventOfCode

  @moduledoc """
  #{ readme("resources/day06/README.md") }
  """

  @impl true
  def run do
    input = File.stream!("resources/day06/input.txt")

    IO.puts("--- Part One ---")
    IO.puts("Result: #{part_one(input)}")

    IO.puts("--- Part Two ---")
    IO.puts("Result: #{part_two(input)}")
  end

  def part_one(args) do
    args
    |> Enum.take(1)
    |> List.first()
    |> String.trim()
    |> String.split("", trim: true)
    |> Stream.chunk_every(4, 1)
    |> Stream.with_index(5)
    |> Stream.take_while(fn {list, _} ->
      list
      |> Enum.frequencies()
      |> map_size()
      |> Kernel.!=(4)
    end)
    |> Enum.to_list()
    |> List.last()
    |> elem(1)
  end

  def part_two(args) do
    args
    |> Enum.take(1)
    |> List.first()
    |> String.trim()
    |> String.split("", trim: true)
    |> Stream.chunk_every(14, 1)
    |> Stream.with_index(15)
    |> Stream.take_while(fn {list, _} ->
      list
      |> Enum.frequencies()
      |> map_size()
      |> Kernel.!=(14)
    end)
    |> Enum.to_list()
    |> List.last()
    |> elem(1)
  end
end
