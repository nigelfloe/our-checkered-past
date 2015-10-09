class Louis
  attr_accessor :player, :checked_move
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
    board_score
  end

  def determine_choices(opponent_choices_array, player)
    opponent_choices_array.map do |opponent_choice|
      choices_array(opponent_choice.last, player)
    end
  end

  def opponent(player)
    (player - 1).abs
  end

  # def choose(board_state, counter, player, choices_hash={})
  #   player_choices = choices_array(board_state, player)
  #
  #   player_choices.each do |choice|
  #     opponent_responses = choices_array(choice.last, opponent(player))
  #     opponent_responses.each do |response|
  #       if counter == 1
  #         choices_hash[choice] = evaluate_board(response.flatten(1), LOUIS)
  #       else
  #         choices_hash[choice] = choose(response.flatten(1), counter-1, opponent(player), choices_hash)
  #       end
  #     end
  #   end
  #   # binding.pry
  #   choices_hash
  # end

  def minimax(node_board_state, depth, player)
    initial_depth ||= depth
    counter ||= 0
    if depth == 0
      return evaluate_board(node_board_state, player)
    end
    if player == LOUIS
      bottom_value = -1000
      best_value = -1000
      choices_array(node_board_state, LOUIS).each do |possible_move|
        val = minimax(possible_move.last, depth - 1, P1)
        best_value = [best_value, val].max
      end
      if best_value > bottom_value && depth == initial_depth
        bottom_value = best_value
        @checked_move = choices_array(node_board_state, LOUIS)[counter]
        # @checked_move = possible_move
        counter += 1
      end
      best_value
    else
      top_value = 1000
      best_value = 1000
      choices_array(node_board_state, P1).each do |possible_move|
        val = minimax(possible_move.last, depth - 1, LOUIS)
        best_value = [best_value, val].min
      end
      if best_value < top_value && depth == initial_depth
        top_value = best_value
        @checked_move = choices_array(node_board_state, P1)[counter]
        # @checked_move = possible_move
      end
      best_value
    end
  end

  def choose(node_board_state, depth, player)
    minimax(node_board_state, depth, player)
    @checked_move
  end

  def anything(board_state, player)
    minimax(possible_move, depth, player)
    array
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
