defmodule AoC4 do

  def is_real_room([name, number, checksum]) do
    chars = name
    |> String.replace("-", "")
    |> String.graphemes
    |> Enum.group_by(fn x -> to_string(x) end)
    |> Enum.group_by(fn {k,v} -> length(v) end)
    charlist = Enum.reverse(for {k,v} <- chars, do: for {c, _} <- v, do: c)
    |> Enum.flat_map(fn x -> x end)
    |> Enum.take(5)
    |> Enum.join("")
    if checksum == charlist do
      number = String.to_integer(number)
      name = name
      |> to_charlist
      |> Enum.map(fn ?- -> ' '; x -> x = x + rem(number,26); if x > 122, do: 96 + (x-122), else: x end)
      |> to_string
      IO.puts "#{name}, #{number}"
      number
    else
      0
    end
  end

  def run1 do
    File.stream!("input4.txt")
    |> Stream.flat_map(&String.split/1)
    |> Stream.map(&Regex.run(~r/^((?:[a-z]*-)+)(\d*)\[([a-z]{5})\]/, &1, capture: :all_but_first))
    |> Enum.map(&is_real_room(&1))
    |> Enum.sum
  end
end
