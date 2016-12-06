defmodule AoC6 do

  def run1 do
    File.read!("input6.txt")
    |> String.split()
    |> Enum.map(&String.to_charlist/1)
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.group_by(&1, fn x -> x end))
    |> Enum.map(&Enum.max_by(&1, fn {k,v} -> length(v) end))
    |> Enum.map(fn {k,v} -> k end)
  end

  def run2 do
    File.read!("input6.txt")
    |> String.split()
    |> Enum.map(&String.to_charlist/1)
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.group_by(&1, fn x -> x end))
    |> Enum.map(&Enum.min_by(&1, fn {k,v} -> length(v) end))
    |> Enum.map(fn {k,v} -> k end)
  end


end
