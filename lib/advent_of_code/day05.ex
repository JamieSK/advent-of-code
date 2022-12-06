defmodule AdventOfCode.Day05 do
  use AdventOfCode

  @moduledoc """
  #{ readme("resources/day05/README.md") }
  """

  @impl true
  def run do
    input = File.stream!("resources/day05/input.txt")

    IO.puts("--- Part One ---")
    IO.puts("Result: #{part_one(input)}")

    IO.puts("--- Part Two ---")
    IO.puts("Result: #{part_two(input)}")
  end

  def part_one(args) do
    initial_stacks = args
    |> Stream.take_while(&(&1 != " 1   2   3   4   5   6   7   8   9 \n"))
    |> Stream.map(fn line ->
      Regex.scan(~r/(?:\[([A-Z])\] ?|   )/, line, capture: :all_but_first)
      |> Enum.take(9)
    end)
    |> Enum.reduce(fn [a,b,c,d,e,f,g,h,i], [j,k,l,m,n,o,p,q,r] -> [a++j,b++k,c++l,d++m,e++n,f++o,g++p,h++q,i++r] end)

    args
    |> Stream.drop_while(fn line -> !String.starts_with?(line, "move") end)
    |> Stream.map(fn line ->
      Regex.run(~r/move (\d+) from (\d+) to (\d+)/, line, capture: :all_but_first)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.reduce(initial_stacks, fn [move, from, to], stacks ->
      from_stack = Enum.at(stacks, from - 1)
      to_move = Enum.take(from_stack, -move) |> Enum.reverse()
      new_from_stack = Enum.drop(from_stack, -move)
      new_to_stack = Enum.at(stacks, to - 1) ++ to_move

      stacks
      |> List.replace_at(from - 1, new_from_stack)
      |> List.replace_at(to - 1, new_to_stack)
    end)
    |> Enum.map(&List.last/1)
    |> Enum.join("")
  end

  def part_two(args) do
    initial_stacks = args
    |> Stream.take_while(&(&1 != " 1   2   3   4   5   6   7   8   9 \n"))
    |> Stream.map(fn line ->
      Regex.scan(~r/(?:\[([A-Z])\] ?|   )/, line, capture: :all_but_first)
      |> Enum.take(9)
    end)
    |> Enum.reduce(fn [a,b,c,d,e,f,g,h,i], [j,k,l,m,n,o,p,q,r] -> [a++j,b++k,c++l,d++m,e++n,f++o,g++p,h++q,i++r] end)

    args
    |> Stream.drop_while(fn line -> !String.starts_with?(line, "move") end)
    |> Stream.map(fn line ->
      Regex.run(~r/move (\d+) from (\d+) to (\d+)/, line, capture: :all_but_first)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.reduce(initial_stacks, fn [move, from, to], stacks ->
      from_stack = Enum.at(stacks, from - 1)
      to_move = Enum.take(from_stack, -move)
      new_from_stack = Enum.drop(from_stack, -move)
      new_to_stack = Enum.at(stacks, to - 1) ++ to_move

      stacks
      |> List.replace_at(from - 1, new_from_stack)
      |> List.replace_at(to - 1, new_to_stack)
    end)
    |> Enum.map(&List.last/1)
    |> Enum.join("")
  end
end
