class Board
  attr_accesor :board
  def initialize
    @board = [[], [], [], [], [], [], []]
  end

  def insert(column, disc)
    board[column] << disc
    
  end
end