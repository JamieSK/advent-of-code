defmodule AdventOfCode.Day07 do
  use AdventOfCode

  @moduledoc """
  #{ readme("resources/day07/README.md") }
  """

  @impl true
  def run do
    input = File.read!("resources/day07/input.txt")

    IO.puts("--- Part One ---")
    IO.puts("Result: #{part_one(input)}")

    IO.puts("--- Part Two ---")
    IO.puts("Result: #{part_two(input)}")
  end

  def part_one(args) do
    args
    |> dir_sizes()
    |> Map.filter(fn {_key, val} -> val <= 100000 end)
    |> Map.values()
    |> Enum.sum()
  end

  def part_two(args) do
    dir_sizes = args |> dir_sizes()
    unused_space = 70000000 - Map.get(dir_sizes, "/")
    needed_space = 30000000 - unused_space
    dir_sizes
    |> Map.filter(fn {_, size} -> size >= needed_space end)
    |> Enum.min_by(fn {_, size} -> size end)
    |> elem(1)
  end
  
  defp dir_sizes(args) do
    args
    |> String.split("\n")
    |> Stream.take_while(fn line -> line != "" end)
    |> Stream.map(fn line ->
      ~r/(?:\$ (?<command>[a-z]+) ?(?<target>.*)?)|(?:dir (?<dirname>[a-z]+))|(?:(?<filesize>[0-9]+) (?<filename>[a-z\.]+))/
      |> Regex.named_captures(line)
      |> Map.reject(fn {_, val} -> val == "" end)
    end)
    |> Enum.reduce({%{"/" => %{}}, [], %{}}, fn command, {map, route, dir_sizes} -> handle_command(map, route, dir_sizes, command) end)
    |> elem(2)
  end

  defp handle_command(map, route, dir_sizes, %{"command" => "cd", "target" => target}) do
    case target do
      ".." -> {map, Enum.drop(route, -1), dir_sizes}
      t -> {map, route ++ [t], dir_sizes}
    end
  end
  
  defp handle_command(map, route, dir_sizes, %{"dirname" => name}) do
    {put_in(map, route ++ [name], %{}), route, dir_sizes}
  end
  
  defp handle_command(map, route, dir_sizes, %{"filename" => name, "filesize" => size}) do
    size_int = String.to_integer(size)
    {
      put_in(map, route ++ [name], size_int),
      route,
      Enum.reduce(1..length(route), dir_sizes, fn dir_index, dir_sizes ->
        Map.update(
          dir_sizes,
          route |> Enum.take(dir_index) |> Enum.join("-"),
          size_int,
          &(&1 + size_int)
        )
      end)
    }
  end
  
  defp handle_command(map, route, dir_sizes, %{"command" => "ls"}), do: {map, route, dir_sizes}
end

# {
#   name: "/",
#   contents: [
#     {
#       name: "a",
#       contents: []
#     },
#     {
#       name: "b.txt",
#       size: 14848514
#     },
#     {
#       name: "c.dat",
#       size: 8504156
#     },
#     {
#       name: "d",
#       contents: []
#     }
#   ]
# }

