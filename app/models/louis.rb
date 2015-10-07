class Louis
  attr_accessor :board, :moves, :start_x, :start_y, :finish_x, :finish_y, :piece_type, :board_state

  def self.evaluate_board(board_state, legal_moves)
  end

  def initialize()
    @moves = []
  end

  def move(original_board)
    @board = original_board
    @board_state = @board.state
    move_coordinates = @board.all_legal_moves.sample
    @start_x = move_coordinates[0][0].to_i
    @start_y = move_coordinates[0][1].to_i
    @finish_x = move_coordinates[1][0].to_i
    @finish_y = move_coordinates[1][1].to_i
    @piece_type = @board_state[start_y][start_x]
    execute
  end

  def execute
    # binding.pry
    if finish_y == 7
      # binding.pry
      @piece_type = "4"
      # @board_state[finish_y][finish_x] = "4"
    end
    @board_state[finish_y][finish_x] = piece_type
    # binding.pry
    @board_state[start_y][start_x] = "0"
    # binding.pry
    (start_x - finish_x).abs == 2 ? jump : push_move
    # binding.pry
    moves
  end

  def push_move
    move = @board_state.deep_dup
    moves.push(move)
  end

  def jump
    @board_state[(start_y + finish_y)/2][(start_x + finish_x)/2] = "0"
    push_move
    # board.set_pieces
    jump_again
  end

  def jump_again
    @board.set_pieces
    jump_coordinates = @board.piece_by_coordinates([finish_x, finish_y]).jumps_available
    if jump_coordinates.length > 0

      start_x = finish_x
      start_y = finish_y
      finish_x = jump_coordinates[0][0]
      finish_y = jump_coordinates[0][1]

      self.move(@board)
    end
  end

end
