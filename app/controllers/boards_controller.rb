class BoardsController < ApplicationController
  def create
    if Board.all.any? {|b| b.state == params[:state].values}
      board = Board.all.select {|b| b.state == params[:state].values}[0]
    else
      board = Board.create(state: params[:state].values, turn: params[:turn], player: params[:player])
    end
    # binding.pry
    # Louis.evaluate_board(board.state, board.all_legal_moves)
    respond_to do |format|
      format.js {render json: Louis.new.move(board).to_json.html_safe}
      format.json {render json: Louis.new.move(board).to_json.html_safe}
    end
  end

end
