defmodule AoC3 do

  def run1 do
    File.stream!("input3.txt")
    |> Stream.flat_map(&String.split/1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk(3)
    |> Enum.count(fn [x,y,z] -> ((x + y) > z) and ((x + z) > y) and ((y + z) > x) end)
  end

  def run2 do
    File.stream!("input3.txt")
    |> Stream.flat_map(&String.split/1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk(3)
    |> Stream.chunk(3)
    |> Stream.flat_map(&List.zip/1)
    |> Enum.count(fn {x,y,z} -> ((x + y) > z) and ((x + z) > y) and ((y + z) > x) end)
  end

  def run3 do
    File.stream!("input3.txt")
    |> Stream.flat_map(&String.split/1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk(3)
    |> Stream.chunk(3)
    |> Stream.flat_map(&List.zip/1)
    |> Stream.map(&Tuple.to_list/1)
    |> Stream.map(&Enum.sort/1)
    |> Enum.count(fn[x,y,z] -> x + y > z end)
  end

  def run4 do
    triangle = fn x,y,z ->
      ((x + y) > z) and ((x + z) > y) and ((y + z) > x)
    end
    File.stream!("input3.txt")
    |> Stream.flat_map(&String.split/1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk(3)
    |> Stream.chunk(3)
    |> Stream.flat_map(&apply(:lists, :zipwith3, [triangle|&1]))
    |> Enum.count(fn x -> x end)
  end
end
