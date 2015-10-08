class Move
  attr_accessor :board, :moves, :start_x, :start_y, :finish_x, :finish_y, :piece_type, :board_state
  P1 = 0
  LOUIS = 1
  P1_GUARD_ROW = 7
  LOUIS_GUARD_ROW = 0
  OFF_SQUARE = "-1"
  EMPTY_SQUARE = "0"
  P1_PIECE = "1"
  LOUIS_PIECE = "2"
  P1_KING = "3"
  LOUIS_KING = "4"

  def initialize(original_board, move_coordinates)
    @moves = []
    @board = original_board
    @board_state = @board.state
    @start_x = move_coordinates[0][0].to_i
    @start_y = move_coordinates[0][1].to_i
    @finish_x = move_coordinates[1][0].to_i
    @finish_y = move_coordinates[1][1].to_i
    @piece_type = @board_state[start_y][start_x]
  end

  def execute
    if board.player == P1 && finish_y == LOUIS_GUARD_ROW
      @piece_type = P1_KING
    elsif board.player == LOUIS && finish_y == P1_GUARD_ROW
      @piece_type = LOUIS_KING
    end
    @board_state[finish_y][finish_x] = piece_type
    @board_state[start_y][start_x] = EMPTY_SQUARE
    (start_x - finish_x).abs == 2 ? jump : push_move
    moves
  end

  def push_move
    move = @board_state.deep_dup
    moves.push(move)
  end

  def jump
    @board_state[(start_y + finish_y)/2][(start_x + finish_x)/2] = EMPTY_SQUARE
    push_move
    jump_again
  end

  def jump_again
    @board.set_pieces
    jump_coordinates = @board.piece_by_coordinates([@finish_x, @finish_y]).jumps_available
    if jump_coordinates.length > 0

      @start_x = @finish_x
      @start_y = @finish_y
      chosen_jump = jump_coordinates.sample
      @finish_x = chosen_jump[0]
      @finish_y = chosen_jump[1]

      execute
    end
  end

end
