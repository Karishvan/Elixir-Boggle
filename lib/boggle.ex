defmodule Boggle do

  @moduledoc """
    Add your boggle function below. You may add additional helper functions if you desire. 
    Test your code by running 'mix test' from the tester_ex_simple directory.
  """

  def boggle(board, words) do
    # Your code here!
    :error  
  end

  def recursiveDFS(board, [{x,y} | _ ], ""), do: []
  def recursiveDFS(board, {x,y}, word), do: recursiveDFS(board, [{x,y} | getNeighbours({x,y}, board)], word)
  def recursiveDFS(board, [], word), do: false
  def recursiveDFS(board, [{x,y} | t], word) do
   letter = elem(elem(board, x),y)
     cond do
      (letter == String.at(word, 0)) -> 
        row = put_elem(elem(board, x), y, "*")
        board = put_elem(board, x, row)
        visit = recursiveDFS(board, {x,y}, String.slice(word, 1..-1//1))
        path = false
        cond do
          visit != false -> path = [ {x,y} | visit]
          true -> false
        end
        #path = [ {x,y} | recursiveDFS(board, {x,y}, String.slice(word, 1..-1//1)) ] #fix this
        row = put_elem(elem(board, x), y, letter)
        board = put_elem(board, x, row)
        path
      true -> 
        recursiveDFS(board, t, word)
    end
  end

  def getNeighbours({x,y}, board) do
    adjacentTiles = [{x-1,y-1}, {x, y-1}, {x+1, y-1}, {x+1, y}, {x+1, y+1}, {x, y+1}, {x-1, y+1}, {x-1, y}]
    filterNeighbours(adjacentTiles, board, [])
  end
  def filterNeighbours([], board, acc), do: Enum.reverse(acc)
  def filterNeighbours([{x,y} | t], board, acc) do
    cond do
      x < 0 or y < 0 -> filterNeighbours(t, board, acc)
      x >= tuple_size(board) or y >= tuple_size(board) -> filterNeighbours(t, board, acc)
      true -> filterNeighbours(t, board, [{x,y} | acc])
    end
  end


end
