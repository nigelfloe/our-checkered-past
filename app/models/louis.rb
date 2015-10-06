class Louis
  def self.evaluate_board(board_state, legal_moves)

    binding.pry
  end

  def self.move(board)
    move_coordinates = board.all_legal_moves.sample
    start_x = move_coordinates[0][0].to_i
    start_y = move_coordinates[0][1].to_i
    finish_x = move_coordinates[1][0].to_i
    finish_y = move_coordinates[1][1].to_i
    board.state[finish_y][finish_x] = board.state[start_y][start_x]
    board.state[start_y][start_x] = "0"
    # binding.pry
    if (start_x - finish_x).abs == 2
      board.state[(start_y + finish_y)/2][(start_x + finish_x)/2] = "0"
    end
    board.state
  end
end
