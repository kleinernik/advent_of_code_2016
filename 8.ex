defmodule AoC8 do

  def create_matrix(x,y,char \\ ".") when is_integer(x) and is_integer(y) and is_binary(char) do
    row = List.duplicate(char, x)
    rows = List.duplicate(row, y)
    rows
  end

  def print_matrix([hd|_] = list) when is_list(list) and is_list(hd) do
    list
    |> Enum.each(&print_matrix(&1))
  end

  def print_matrix([hd|_] = list) when is_list(list) and is_binary(hd) do
    list
    |> Enum.each(&IO.write(&1))
    IO.write("\n")
  end

  def rect(list, a, b) when is_list(list) and a > 0 and b > 0 do
    _rect(list, a, b, 0, [])
  end

  def rect(list, a, b) when is_list(list) do
    list
  end

  def _rect([hd|tl], a, b, current_row, new_list) when current_row < b do
    new_row = (List.duplicate("#", a) ++ Enum.drop(hd, a))
    |> Enum.take(length(hd))
    _rect(tl, a, b, current_row + 1, [new_row|new_list])
  end

  def _rect([hd|tl] , a, b, current_row, new_list) do
    _rect(tl, a, b, current_row + 1, [hd|new_list])
  end

  def _rect([] , a, b, current_row, new_list) do
    new_list
    |> Enum.reverse
  end

  def rotate_row_right(list, y, b) when is_list(list)  and y >= 0 and y < length(list)do
    old_row = Enum.at(list, y)
    b = rem(b, length(old_row))
    new_row = Enum.take(old_row, -b) ++ Enum.drop(old_row, -b)
    List.replace_at(list, y, new_row)
  end

  def rotate_row_right(list, y, b) do
    list
  end

  def rotate_column_down(list, x, b) do
    list
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> rotate_row_right(x, b)
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end

  def parse_command("rect " <> <<rest::binary>>) do
    [a, b] = rest
    |> String.trim
    |> String.split("x")
    |> Enum.map(&String.to_integer/1)
    fun = fn list -> rect(list, a, b) end
  end

  def parse_command("rotate row y=" <> <<rest::binary>>) do
    [a, b] = rest
    |> String.trim
    |> String.split(" by ")
    |> Enum.map(&String.to_integer/1)
    fun = fn list -> rotate_row_right(list, a, b) end
  end

  def parse_command("rotate column x=" <> <<rest::binary>>) do
    [a, b] = rest
    |> String.trim
    |> String.split(" by ")
    |> Enum.map(&String.to_integer/1)
    fun = fn list -> rotate_column_down(list, a, b) end
  end

  def run1 do
    init_matrix = create_matrix(50,6, " ")
    matrix = File.stream!("input8.txt")
    |> Stream.map(&parse_command/1)
    |> Enum.reduce(init_matrix, fn (fun, acc) -> fun.(acc) end)

    print_matrix(matrix)
    matrix
    |> List.flatten
    |> Enum.filter(fn x -> x == "#" end)
    |> Enum.count
  end

end
