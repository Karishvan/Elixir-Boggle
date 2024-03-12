defmodule Boggle do

  @moduledoc """
    Add your boggle function below. You may add additional helper functions if you desire. 
    Test your code by running 'mix test' from the tester_ex_simple directory.
  """

  def boggle(board, words) do
    # Your code here!
    :error  
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
