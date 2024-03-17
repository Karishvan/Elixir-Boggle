defmodule BoggleTest do
  use ExUnit.Case
  doctest Boggle

  test "test_1_mass_4x4 " do 
    {:ok, raw} = File.read("lists/word_list_500.txt")
    words = raw |> String.split("\r\n", trim: true)
    dice_list = [ "rifobx", "ifehey", "denows", "utoknd", "hmsrao", "lupets", "acitoa", "ylgkue", 
                  "aaaaaa", "ehispn", "vetign", "baliyt", "ezavnd", "ralesc", "uwilrg", "pacemd" ]
    letters = dice_list |> Enum.map(fn str -> String.codepoints str end) 
                        |> Enum.shuffle |> Enum.map(fn row -> hd row end)
    board = letters |> (Enum.chunk_every 4) |> (Enum.map &(List.to_tuple &1)) |> List.to_tuple

    found = for _ <- 1..1000, do: Boggle.boggle(board, words) |> validate_return_type
    
    a1 = Enum.all? found, fn n -> n end
    assert a1, "Return type not correct"

    IO.puts "MASS 4x4 Passed"
  end

  test "test_2a_given_2x2 " do
    {:ok, raw} = File.read("lists/word_list_3000.txt")
    words = raw |> String.split("\r\n", trim: true)
    board = { {"e", "a"}, 
              {"s", "t"} }

    found = Boggle.boggle board, words

    a1 = validate_return_type found 
    assert a1, "Return type not correct"
    a2 = wordsLegal? found, words 
    assert a2, "Returned words not in list"
    a3 = wordsInBoard? found, board
    assert a3, "Returned words not in board"

    score = getScore found
    IO.puts "2x2 SCORE: #{score}"
  end

  test "test_2b_given_4x4 " do 
    {:ok, raw} = File.read("lists/word_list_3000.txt")
    words = raw |> String.split("\r\n", trim: true)
    board = { {"i", "s", "u", "o"}, 
              {"o", "s", "v", "e"}, 
              {"n", "e", "p", "a"}, 
              {"n", "t", "s", "u"} }

    found = Boggle.boggle board, words

    a1 = validate_return_type found 
    assert a1, "Return type not correct"
    a2 = wordsLegal? found, words 
    assert a2, "Returned words not in list"
    a3 = wordsInBoard? found, board
    assert a3, "Returned words not in board"

    score = getScore found
    IO.puts "4x4 SCORE: #{score}"
  end

  test "test_3a_small_2x2 " do
    {:ok, raw} = File.read("lists/word_list_scrabble_2019.txt")
    words = raw |> String.split("\r\n", trim: true)
    board = { {"e", "a"}, 
              {"s", "t"} }

    found = Boggle.boggle board, words

    a1 = validate_return_type found 
    assert a1, "Return type not correct"
    a2 = wordsLegal? found, words 
    assert a2, "Returned words not in list"
    a3 = wordsInBoard? found, board
    assert a3, "Returned words not in board"

    score = getScore found
    IO.puts "2x2 SCORE: #{score}"
  end

  test "test_3b_medium_4x4 " do 
    {:ok, raw} = File.read("lists/word_list_scrabble_2019.txt")
    words = raw |> String.split("\r\n", trim: true)
    board = { {"i", "s", "u", "o"}, 
              {"o", "s", "v", "e"}, 
              {"n", "e", "p", "a"}, 
              {"n", "t", "s", "u"} }

    found = Boggle.boggle board, words

    a1 = validate_return_type found 
    assert a1, "Return type not correct"
    a2 = wordsLegal? found, words 
    assert a2, "Returned words not in list"
    a3 = wordsInBoard? found, board
    assert a3, "Returned words not in board"

    score = getScore found
    IO.puts "4x4 SCORE: #{score}"
  end

  test "test_3c_large_8x8 " do 
    {:ok, raw} = File.read("lists/word_list_scrabble_2019.txt")
    words = raw |> String.split("\r\n", trim: true)
    board = { {"o", "c", "n", "e", "a", "s", "r", "a"}, 
              {"c", "r", "i", "s", "h", "t", "i", "r"},  
              {"l", "l", "a", "n", "n", "r", "e", "n"},
              {"g", "e", "n", "s", "s", "a", "q", "n"},
              {"d", "a", "m", "c", "o", "b", "n", "u"}, 
              {"n", "r", "o", "o", "s", "y", "e", "n"},
              {"a", "t", "s", "a", "r", "s", "o", "n"},
              {"b", "e", "s", "s", "n", "n", "i", "s"} }

    found = Boggle.boggle board, words

    a1 = validate_return_type found 
    assert a1, "Return type not correct"
    a2 = wordsLegal? found, words 
    assert a2, "Returned words not in list"
    a3 = wordsInBoard? found, board
    assert a3, "Returned words not in board"

    score = getScore found
    IO.puts "8x8 SCORE: #{score}"
  end

  test "test_3d_mega_16x16 " do 
    {:ok, raw} = File.read("lists/word_list_scrabble_2019.txt")
    words = raw |> String.split("\r\n", trim: true)
    board = { {"a", "q", "o", "a", "u", "s", "i", "e", "a", "r", "t", "u", "e", "l", "r", "o"}, 
					    {"l", "n", "u", "c", "r", "s", "u", "r", "s", "d", "i", "r", "z", "t", "o", "m"},
					    {"q", "c", "a", "c", "l", "o", "d", "q", "t", "y", "i", "y", "c", "r", "a", "v"},
					    {"d", "e", "s", "m", "p", "a", "n", "t", "s", "e", "m", "t", "d", "e", "s", "t"},
					    {"i", "t", "q", "e", "e", "t", "r", "o", "a", "b", "n", "o", "a", "h", "n", "a"},
					    {"d", "n", "e", "c", "r", "p", "o", "l", "v", "n", "e", "z", "s", "m", "i", "m"},
					    {"p", "l", "o", "r", "s", "s", "i", "s", "t", "t", "u", "g", "c", "t", "o", "g"},
					    {"b", "a", "l", "v", "r", "i", "d", "n", "m", "o", "l", "s", "b", "a", "n", "v"},
					    {"o", "j", "n", "a", "o", "y", "l", "o", "i", "f", "g", "a", "e", "s", "z", "a"},
					    {"n", "m", "e", "l", "l", "s", "e", "n", "n", "p", "i", "r", "m", "c", "i", "n"},
					    {"l", "s", "a", "l", "n", "m", "u", "c", "r", "l", "a", "r", "m", "b", "a", "m"},
					    {"p", "e", "m", "h", "z", "a", "r", "n", "y", "e", "c", "l", "p", "e", "s", "r"},
					    {"i", "s", "n", "o", "u", "s", "t", "a", "o", "s", "c", "e", "i", "c", "i", "o"},
					    {"r", "d", "e", "a", "s", "d", "o", "l", "d", "l", "e", "s", "r", "l", "o", "m"},
					    {"p", "g", "u", "r", "l", "v", "o", "c", "l", "s", "e", "r", "b", "m", "e", "m"},
					    {"s", "i", "a", "s", "n", "a", "p", "r", "m", "u", "r", "h", "t", "o", "s", "c"} }

    found = Boggle.boggle board, words

    a1 = validate_return_type found 
    assert a1, "Return type not correct"
    a2 = wordsLegal? found, words 
    assert a2, "Returned words not in list"
    a3 = wordsInBoard? found, board
    assert a3, "Returned words not in board"

    score = getScore found
    IO.puts "16x16 SCORE: #{score}"
  end

  def validate_return_type(found) when not (is_map found), do: false
  def validate_return_type found do
    mp = found |> Map.to_list
    case mp do
      [] -> false
      [entry|_] ->
        case entry do
          { word, [{x, y} | _] } -> (String.valid? word) and (is_integer x) and (is_integer y)
          _ -> false
        end
    end
  end

  def wordsLegal? found, words do
    word_set = MapSet.new(words)
    Enum.all? (for w <- (Map.keys found), do: w in word_set), &(&1)
  end

  def wordsInBoard? found, board do
    Enum.all? (for entry <- (Map.to_list found), 
      do: (validate_word board, entry) and (validate_coords entry)), &(&1)
  end
  def validate_word(board, {word, coords}) do 
    chars = Enum.zip (String.codepoints word), coords
    Enum.all? (for {c, {x, y}} <- chars, do: c == get_cell(board, x, y)), &(&1)
  end
  def validate_coords({_, coords}) do
    dup = (length coords) == (MapSet.size (MapSet.new coords))
    x_coords = for {x, _} <- coords, do: x
    x_ok = Enum.zip(x_coords, tl x_coords) |> Enum.all?(fn {x1, x2} -> abs(x1-x2) <= 1 end)
    y_coords = for {_, y} <- coords, do: y
    y_ok = Enum.zip(y_coords, tl y_coords) |> Enum.all?(fn {y1, y2} -> abs(y1-y2) <= 1 end)
    dup and x_ok and y_ok
  end
  def get_cell(board, x, y), do: elem(elem(board, x), y)

  def getScore found do
    w_scores = {1, 2, 4, 6, 9, 12, 16, 20}  
    words = Map.keys found
    s = for w <- words, do: if( String.length(w) <= 8, do: elem(w_scores, String.length(w)-1), else: 20)
    Enum.sum s
  end

end
