class BoardsController < ApplicationController
  def create
    if Board.all.any? {|b| b.state == params[:state].values}
      board = Board.all.select {|b| b.state == params[:state].values}[0]
    else
      board = Board.create(state: params[:state].values, turn: params[:turn], player: params[:player])
    end
    respond_to do |format|
      format.js {render json: Louis.new.choose(board.state, 2, 1).to_json.html_safe}
    end
  end

end
