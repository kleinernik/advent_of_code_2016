defmodule AoC7 do

  def split_hypernet(list) when is_list(list) do
    no_hypernet = Enum.take_every(list, 2)
    hypernet = Enum.drop_every(list, 2)
    {no_hypernet, hypernet}
  end

  def is_supporting_tls({no_hypernet, hypernet}) do
    Enum.any?(no_hypernet, &any_abba/1) and not Enum.any?(hypernet, &any_abba/1)
  end

  def any_abba(in_string) do
    in_string
    |> String.graphemes
    |> Enum.chunk(4,1)
    |> Enum.any?(fn x -> is_abba(x) end)
  end

  def is_abba([a, b, b, a]) when a != b, do: true
  def is_abba(_), do: false

  def run1 do
    File.read!("input7.txt")
    |> String.split()
    |> Enum.map(&String.split(&1,~r/\[|\]/))
    |> Enum.map(&split_hypernet/1)
    |> Enum.filter(&is_supporting_tls/1)
    |> Enum.count
  end

  # Part Two -------------------------------------------------------------------

  def is_supporting_ssl({no_hypernet, hypernet}) do
    abas = Enum.flat_map(no_hypernet, &find_aba/1)
    babs = Enum.map(abas, fn [a, b, a] -> "#{b}#{a}#{b}" end)
    hypernet = hypernet
    |> Enum.filter(&Enum.any?(babs, fn bab -> String.contains?(&1, bab) end))
    length(hypernet) > 0
  end

  def find_aba(in_string) do
    in_string
    |> String.graphemes
    |> Enum.chunk(3,1)
    |> Enum.filter(fn x -> is_aba(x) end)
  end

  def is_aba([a, b, a]) when a != b, do: true
  def is_aba(_), do: false

  def run2 do
    File.read!("input7.txt")
    |> String.split()
    |> Enum.map(&String.split(&1,~r/\[|\]/))
    |> Enum.map(&split_hypernet/1)
    |> Enum.filter(&is_supporting_ssl/1)
    |> Enum.count
  end


end
