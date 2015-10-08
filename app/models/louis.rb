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

  def determine_choices(opponent_choices_array, player)
    opponent_choices_array.map do |opponent_choice|
      choices_array(opponent_choice.last, player)
    end
  end

  def opponent(player)
    (player - 1).abs
  end

  def choose(board_state, counter, player, choices_hash)
    unless counter == 0
      player_choices = choices_array(board_state, player)

      player_choices.each do |choice|
        binding.pry
        opponent_responses = choices_array(choice.last, opponent(player))
        binding.pry
        choices_hash[choice] = opponent_responses.map do |response|
          binding.pry
          if counter == 1
            evaluate_board(response, LOUIS)
          else
            choose(response, counter-1, opponent(player), choices_hash)
          end
        end
      end
    end
    choices_hash
  end

  # def decide(board)
  #   choose(board, 4, LOUIS).each do |louis_move, p1_responses|
  #     p1_responses.sort_by! do |response|
  #       evaluate_board(response.last, LOUIS)
  #     end
  #     #select p1's best response
  #     game_tree[louis_move] = evaluate_board(p1_responses.first.last, LOUIS)
  #   end
  #
  #
  #   best_choices = game_tree.select do |louis_move, outcome_value|
  #     outcome_value == game_tree.values.max
  #   end
  #   best_choices.keys.sample
  # end
  #
  # def choose(board)
  #   louis_choices = choices_array(board.state, LOUIS)
  #   choices_hash = {}
  #   louis_choices.each do |choice|
  #     choices_array(choice.last, )
  #     choices_hash[choice] = 0
  #   end
  #   p1_choices = determine_choices(louis_choices, P1)
  #   binding.pry
  #   louis_responses = determine_choices(p1_choices, LOUIS)
  #
  #   # p1_choices = louis_choices.map do |louis_choice|
  #   #   choices_array(louis_choice.last, P1)
  #   # end
  #   # louis_responses = p1_choices.map do |p1_choice|
  #   # end
  #
  #   # game_tree = Hash[louis_choices.zip(p1_choices)]
  #   game_tree.each do |louis_move, p1_responses|
  #     p1_responses.sort_by! do |response|
  #       evaluate_board(response.last, LOUIS)
  #     end
  #     #select p1's best response
  #     game_tree[louis_move] = evaluate_board(p1_responses.first.last, LOUIS)
  #   end
  #
  #
  #   best_choices = game_tree.select do |louis_move, outcome_value|
  #     outcome_value == game_tree.values.max
  #   end
  #   best_choices.keys.sample
  # end

  def choices_array(board_state, player)
    board = Board.new(state: board_state, player: player)
    board.all_legal_moves.map do |coord_pair|
      board_copy = Board.new(state: board_state, player: player)
      Move.new(board_copy, coord_pair).execute
    end
  end
end
