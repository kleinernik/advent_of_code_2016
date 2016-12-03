defmodule AoC1 do

  def go([{"R", n} | rest], {x, y}, :north, visited) do
    new = {x + n, y}
    bearing = :east
    _go(rest, {x, y}, new, bearing, visited)
  end

  def go([{"L", n} | rest], {x, y}, :north, visited) do
    new = {x - n, y}
    bearing = :west
    _go(rest, {x, y}, new, bearing, visited)
  end

  def go([{"R", n} | rest], {x, y}, :south, visited) do
    new = {x - n, y}
    bearing = :west
    _go(rest, {x, y}, new, bearing, visited)
  end

  def go([{"L", n} | rest], {x, y}, :south, visited) do
    new = {x + n, y}
    bearing = :east
    _go(rest, {x, y}, new, bearing, visited)
  end

  def go([{"R", n} | rest], {x, y}, :east, visited) do
    new = {x, y - n}
    bearing = :south
    _go(rest, {x, y}, new, bearing, visited)
  end

  def go([{"L", n} | rest], {x, y}, :east, visited) do
    new = {x, y + n}
    bearing = :north
    _go(rest, {x, y}, new, bearing, visited)
  end

  def go([{"R" ,n} | rest], {x, y}, :west, visited) do
    new = {x, y + n}
    bearing = :north
    _go(rest, {x, y}, new, bearing, visited)
  end

  def go([{"L", n} | rest], {x, y}, :west, visited) do
    new = {x, y - n}
    bearing = :south
    _go(rest, {x, y}, new, bearing, visited)
  end

  def go([], {x, y}, _bearing, _) do
    {x, y}
  end

  def _go(rest, {x, y}, {n_x, n_y} = new, bearing, visited) do
    new_v = for d_x <- x..n_x, d_y <- y..n_y, do: {d_x, d_y}
    e = Enum.find(new_v|>tl, &(&1 in visited))
    if e != nil, do: e, else: go(rest, new, bearing,  new_v ++ visited)
  end

  def run() do
    input = ~s(R5, R4, R2, L3, R1, R1, L4, L5, R3, L1, L1, R4, L2, R1, R4, R4, L2, L2, R4, L4, R1, R3, L3, L1, L2, R1, R5, L5, L1, L1, R3, R5, L1, R4, L5, R5, R1, L185, R4, L1, R51, R3, L2, R78, R1, L4, R188, R1, L5, R5, R2, R3, L5, R3, R4, L1, R2, R2, L4, L4, L5, R5, R4, L4, R2, L5, R2, L1, L4, R4, L4, R2, L3, L4, R2, L3, R3, R2, L2, L3, R4, R3, R1, L4, L2, L5, R4, R4, L1, R1, L5, L1, R3, R1, L2, R1, R1, R3, L4, L1, L3, R2, R4, R2, L2, R1, L5, R3, L3, R3, L1, R4, L3, L3, R4, L2, L1, L3, R2, R3, L2, L1, R4, L3, L5, L2, L4, R1, L4, L4, R3, R5, L4, L1, L1, R4, L2, R5, R1, R1, R2, R1, R5, L1, L3, L5, R2)

    steps = for [_h, dir, num] <- Regex.scan(~r/(R|L)(\d*)/, input), do: {dir, elem(Integer.parse(num), 0)}

    dest = go(steps, {0,0}, :north, [])
    {x, y} = dest
    IO.inspect dest
    IO.inspect abs(x) + abs(y)
  end
end
