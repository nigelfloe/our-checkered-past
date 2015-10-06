class BoardsController < ApplicationController
  def create
    if Board.all.any? {|b| b.state == params[:state].values}
      board = Board.all.select {|b| b.state == params[:state].values}[0]
    else
      board = Board.create(state: params[:state].values, turn: params[:turn], player: params[:player])
    end
  end

end
