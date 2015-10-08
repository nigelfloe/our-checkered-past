class Louis
  P1_GUARD_ROW = 7
  LOUIS_GUARD_ROW = 0
  OFF_SQUARE = "-1"
  EMPTY_SQUARE = "0"
  P1_PIECE = "1"
  LOUIS_PIECE = "2"
  P1_KING = "3"
  LOUIS_KING = "4"

  def evaluate_board(board_state)
    current_state = board_state.flatten
    p1_pieces = current_state.select {|s| s == P1_PIECE}.count
    p1_kings = current_state.select {|s| s == P1_KING}.count
    p1_guards = board_state[P1_GUARD_ROW].select{|s| s == P1_PIECE}.count

    louis_pieces = current_state.select {|s| s == LOUIS_PIECE}.count
    louis_kings = current_state.select {|s| s == LOUIS_KING}.count
    louis_guards = board_state[LOUIS_GUARD_ROW].select{|s| s == LOUIS_PIECE}.count

    p1_score = (p1_pieces * 2) + (p1_kings * 5) + p1_guards
    louis_score = (louis_pieces * 2) + (louis_kings * 5) + louis_guards

    board_score = louis_score - p1_score
  end-

  def choose(board)
    choices = board.all_legal_moves.map do |coord_pair|
      board_copy = Board.new(state: board.state, player: board.player)
      Move.new(board_copy, coord_pair).execute
    end
    choices.sort_by! do |possible_move|
      evaluate_board(possible_move.last)
    end
    best_choices = choices.select do |possible_move|
      evaluate_board(possible_move.last) == evaluate_board(choices.last.last)
    end
    best_choices.sample
  end



end
