defmodule AoC2 do

  def move(pos, move) do
    case {pos, move} do
      {top_row, "U"} when top_row in 1..3 -> top_row
      {top_center_row, "D"} when top_center_row in 1..6 -> top_center_row + 3
      {bottom_row, "D"} when bottom_row in 7..9 -> bottom_row
      {bottom_center_row, "U"} when bottom_center_row in 4..9 -> bottom_center_row - 3
      {left_col, "L"} when left_col in [1,4,7] -> left_col
      {left_middle_col, "R"} when left_middle_col in [1,4,7,2,5,8] -> left_middle_col + 1
      {right_col, "R"} when right_col in [3,6,9] -> right_col
      {right_middle_col, "L"} when right_middle_col in [3,6,9,2,5,8] -> right_middle_col - 1
    end
  end

  def move2(pos, move) do
    case {pos, move} do
      #{top_row, "U"} when top_row in [5,2,1,4,9] -> top_row
      {top_center_row, "D"} when top_center_row in [1,0xB] -> top_center_row + 2
      {top_center_row, "D"} when top_center_row in [2,3,4,6,7,8] -> top_center_row + 4
      #{bottom_row, "D"} when bottom_row in [5,0xA,0xC,0xD,9] -> bottom_row
      {bottom_center_row, "U"} when bottom_center_row in [3,0xD] -> bottom_center_row - 2
      {bottom_center_row, "U"} when bottom_center_row in [6,7,8,0xA,0xB,0xC] -> bottom_center_row - 4
      #{left_col, "L"} when left_col in [1,2,5,0xA,0xD] -> left_col
      {left_middle_col, "R"} when not left_middle_col in [1,4,9,0xC,0xD] -> left_middle_col + 1
      #{right_col, "R"} when right_col in [1,4,9,0xC,0xD] -> right_col
      {right_middle_col, "L"} when not right_middle_col in [1,2,5,0xA,0xD] -> right_middle_col - 1
      {pos, _} -> pos
    end
  end

  def read_input() do
    s =
    ~s(UDRLRRRUULUUDULRULUDRDRURLLDUUDURLUUUDRRRLUUDRUUDDDRRRLRURLLLDDDRDDRUDDULUULDDUDRUUUDLRLLRLDUDUUUUDLDULLLDRLRLRULDDDDDLULURUDURDDLLRDLUDRRULDURDDLUDLLRRUDRUDDDLLURULRDDDRDRRLLUUDDLLLLRLRUULRDRURRRLLLLDULDDLRRRRUDRDULLLDDRRRDLRLRRRLDRULDUDDLDLUULRDDULRDRURRURLDULRUUDUUURDRLDDDURLDURLDUDURRLLLLRDDLDRUURURRRRDRRDLUULLURRDLLLDLDUUUDRDRULULRULUUDDULDUURRLRLRRDULDULDRUUDLLUDLLLLUDDULDLLDLLURLLLRUDRDLRUDLULDLLLUDRLRLUDLDRDURDDULDURLLRRRDUUDLRDDRUUDLUURLDRRRRRLDDUUDRURUDLLLRRULLRLDRUURRRRRLRLLUDDRLUDRRDUDUUUDRUDULRRULRDRRRDDRLUUUDRLLURURRLLDUDRUURDLRURLLRDUDUUDLLLUULLRULRLDLRDDDU
DRRRDRUDRLDUUDLLLRLULLLUURLLRLDRLURDRDRDRLDUUULDRDDLDDDURURUDRUUURDRDURLRLUDRRRDURDRRRDULLRDRRLUUUURLRUULRRDUDDDDUURLDULUDLLLRULUDUURRDUULRRDDURLURRUDRDRLDLRLLULULURLRDLRRRUUURDDUUURDRDRUURUDLULDRDDULLLLLRLRLLUDDLULLUDDLRLRDLDULURDUDULRDDRLUDUUDUDRLLDRRLLDULLRLDURUDRLRRRDULUUUULRRLUDDDLDUUDULLUUURDRLLULRLDLLUUDLLUULUULUDLRRDDRLUUULDDRULDRLURUURDLURDDRULLLLDUDULUDURRDRLDDRRLRURLLRLLLLDURDLUULDLDDLULLLRDRRRDLLLUUDDDLDRRLUUUUUULDRULLLDUDLDLURLDUDULRRRULDLRRDRUUUUUURRDRUURLDDURDUURURULULLURLLLLUURDUDRRLRRLRLRRRRRULLDLLLRURRDULLDLLULLRDUULDUDUDULDURLRDLDRUUURLLDLLUUDURURUD
UDUUUUURUDLLLRRRDRDRUDDRLLDRRLDRLLUURRULUULULRLLRUDDRLDRLUURDUDLURUULLLULLRRRULRLURRDDULLULULRUDDDUURDRLUDUURRRRUUULLRULLLDLURUDLDDLLRRRULDLLUURDRRRDRDURURLRUDLDLURDDRLLLUUDRUULLDLLLLUUDRRURLDDUDULUDLDURDLURUURDUUUURDLLLRUUURDUUUDLDUDDLUDDUDUDUDLDUDUUULDULUURDDLRRRULLUDRRDLUDULDURUURULLLLUDDDLURURLRLRDLRULRLULURRLLRDUDUDRULLRULRUDLURUDLLDUDLRDRLRDURURRULLDDLRLDDRLRDRRDLRDDLLLLDUURRULLRLLDDLDLURLRLLDULRURRRRDULRLRURURRULULDUURRDLURRDDLDLLLRULRLLURLRLLDDLRUDDDULDLDLRLURRULRRLULUDLDUDUDDLLUURDDDLULURRULDRRDDDUUURLLDRDURUDRUDLLDRUD
ULRDULURRDDLULLDDLDDDRLDUURDLLDRRRDLLURDRUDDLDURUDRULRULRULULUULLLLDRLRLDRLLLLLRLRRLRLRRRDDULRRLUDLURLLRLLURDDRRDRUUUDLDLDRRRUDLRUDDRURRDUUUDUUULRLDDRDRDRULRLLDLDDLLRLUDLLLLUURLDLRUDRLRDRDRLRULRDDURRLRUDLRLRLDRUDURLRDLDULLUUULDRLRDDRDUDLLRUDDUDURRRRDLDURRUURDUULLDLRDUDDLUDDDRRRULRLULDRLDDRUURURLRRRURDURDRULLUUDURUDRDRLDLURDDDUDDURUDLRULULURRUULDRLDULRRRRDUULLRRRRLUDLRDDRLRUDLURRRDRDRLLLULLUULRDULRDLDUURRDULLRULRLRRURDDLDLLRUUDLRLDLRUUDLDDLLULDLUURRRLRDULRLRLDRLDUDURRRLLRUUDLUURRDLDDULDLULUUUUDRRULLLLLLUULDRULDLRUDDDRDRDDURUURLURRDLDDRUURULLULUUUDDLRDULDDLULDUDRU
LRLRLRLLLRRLUULDDUUUURDULLLRURLDLDRURRRUUDDDULURDRRDURLRLUDLLULDRULLRRRDUUDDRDRULLDDULLLUURDLRLRUURRRLRDLDUDLLRLLURLRLLLDDDULUDUDRDLRRLUDDLRDDURRDRDUUULLUURURLRRDUURLRDLLUDURLRDRLURUURDRLULLUUUURRDDULDDDRULURUULLUDDDDLRURDLLDRURDUDRRLRLDLRRDDRRDDRUDRDLUDDDLUDLUDLRUDDUDRUDLLRURDLRUULRUURULUURLRDULDLDLLRDRDUDDDULRLDDDRDUDDRRRLRRLLRRRUUURRLDLLDRRDLULUUURUDLULDULLLDLULRLRDLDDDDDDDLRDRDUDLDLRLUDRRDRRDRUURDUDLDDLUDDDDDDRUURURUURLURLDULUDDLDDLRUUUULRDRLUDLDDLLLRLLDRRULULRLRDURRRLDDRDDRLU)
    String.split(s, "\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.graphemes/1)
  end

  def run() do
    Enum.reduce(read_input, [5],
      fn line, keys ->
        [Enum.reduce(line, hd(keys), fn(x, acc) -> move2(acc, x) end)|keys]
      end)
    |> Enum.reverse
    |> tl
    |> Enum.map(&Integer.to_string(&1, 16))
    |> Enum.join("")
  end

end
