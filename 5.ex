defmodule AoC5 do

  def run1 do
    Stream.iterate(0, &(&1+1))
    |> Stream.map(&"ojvtpuvg#{&1}")
    |> Stream.map(fn x -> x = :erlang.md5(x); Base.encode16(x, case: :lower) end)
    |> Stream.filter(&String.starts_with?(&1, "00000"))
    |> Stream.map(&String.at(&1,5))
    |> Enum.take(8)
    |> Enum.join("")
  end

  def test_char(passwd, pos, char) do
    pos = String.to_integer(pos)
    passwd = if Enum.at(passwd, pos) == " ", do: List.replace_at(passwd, pos, char), else: passwd
    if Enum.any?(passwd, fn x -> x == " " end) do
      {:cont, passwd}
    else
      {:halt, passwd}
    end
  end

  def run2 do
    passwd = List.duplicate(" ", 8)
    Stream.iterate(0, &(&1+1))
    |> Stream.map(&"ojvtpuvg#{&1}")
    |> Stream.map(fn x -> x = :erlang.md5(x); Base.encode16(x, case: :lower) end)
    |> Stream.filter(&String.starts_with?(&1, "00000"))
    |> Stream.filter(fn x -> String.at(x, 5) in ["0","1","2","3","4","5","6","7"] end)
    |> Stream.map(fn x -> {String.at(x,5),String.at(x,6)} end)
    |> Enum.reduce_while(passwd, fn {pos,char}, passwd -> test_char(passwd, pos, char) end)
    |> Enum.join("")
  end
end
