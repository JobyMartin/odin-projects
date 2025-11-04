
class King < Piece
  attr_accessor :position
  
  def initialize(color, position)
    symbol = color == :white ? " \u2654" : " \u265A"
    super(color, position, symbol)
  end

  def valid_moves(board)
    moves = []
    row, col = position

    directions = [
      [-1, -1], [-1, 0], [-1, 1], [0, -1],
      [0, 1], [1, -1], [1, 0], [1, 1]
    ]

    directions.each do |row_offset, col_offset|
      new_row, new_col = row + row_offset, col + col_offset
  
      next unless new_row.between?(0, 7) && new_col.between?(0, 7)
  
      target_piece = board[new_row][new_col]
      if target_piece.nil? || target_piece.color != color
        moves << [new_row, new_col]
      end
    end
    
    moves
  end
end