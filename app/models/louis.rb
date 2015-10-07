class Louis
  def self.evaluate_board(board_state, legal_moves)

    binding.pry
  end

  def self.move(board)
    @board = board
    @moves = []
    move_coordinates = board.all_legal_moves.sample
    @start_x = move_coordinates[0][0].to_i
    @start_y = move_coordinates[0][1].to_i
    @finish_x = move_coordinates[1][0].to_i
    @finish_y = move_coordinates[1][1].to_i
    execute
  end

  def self.execute
    @piece_type = @board.state[@start_y][@start_x]
    @board.state[@finish_y][@finish_x] = (@finish_y == 7 ? "4" : @piece_type)
    @board.state[@start_y][@start_x] = "0"
    (@start_x - @finish_x).abs == 2 ? jump : @moves << @board.state
    @moves
  end

  def self.jump
    @board.state[(@start_y + @finish_y)/2][(@start_x + @finish_x)/2] = "0"
    @moves << @board.state
    @board.set_pieces
    jump_again
  end

  def self.jump_again
    # @board.set_pieces
    jump_coordinates = @board.piece_by_coordinates([@finish_x, @finish_y]).jumps_available
    if jump_coordinates.length > 0
      @start_x = @finish_x
      @start_y = @finish_y
      @finish_x = jump_coordinates[0][0]
      @finish_y = jump_coordinates[0][1]
      self.execute
    end
  end

end
