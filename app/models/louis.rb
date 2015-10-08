class Louis
  attr_accessor :player
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


  def evaluate_board(board_state, player)

    current_state = board_state.flatten
    p1_pieces = current_state.select {|s| s == P1_PIECE}.count
    p1_kings = current_state.select {|s| s == P1_KING}.count
    p1_guards = board_state[P1_GUARD_ROW].select{|s| s == P1_PIECE}.count

    louis_pieces = current_state.select {|s| s == LOUIS_PIECE}.count
    louis_kings = current_state.select {|s| s == LOUIS_KING}.count
    louis_guards = board_state[LOUIS_GUARD_ROW].select{|s| s == LOUIS_PIECE}.count

    p1_score = (p1_pieces * 2) + (p1_kings * 5) + p1_guards
    louis_score = (louis_pieces * 2) + (louis_kings * 5) + louis_guards

    if player == LOUIS
      board_score = louis_score - p1_score
    elsif player == P1
      board_score = p1_score - louis_score
    end
  end

  def choose(board)
    louis_choices = choices_array(board.state, LOUIS)

    p1_choices = louis_choices.map do |louis_choice|
      choices_array(louis_choice.last, P1)
    end

    game_tree = Hash[louis_choices.zip(p1_choices)]

    game_tree.each do |louis_move, p1_responses|
      p1_responses.sort_by! do |response|
        evaluate_board(response.last, LOUIS)
      end
      #select p1's best response
      game_tree[louis_move] = evaluate_board(p1_responses.first.last, LOUIS)
    end


    best_choices = game_tree.select do |louis_move, outcome_value|
      outcome_value == game_tree.values.max
    end
    best_choices.keys.sample
  end

  def choices_array(board_state, player)
    board = Board.new(state: board_state, player: player)
    board.all_legal_moves.map do |coord_pair|
      board_copy = Board.new(state: board_state, player: player)
      Move.new(board_copy, coord_pair).execute
    end
  end
end
