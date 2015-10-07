class Board < ActiveRecord::Base
  attr_accessor :pieces
  validates_presence_of :state, :player
  serialize :state
  after_initialize do |board|
    set_pieces
  end

  def all_legal_moves
    players_pieces = pieces.select{|piece| piece.owner == player}
    players_pieces.map{|piece| piece.legal_moves if piece.legal_moves.any?}.compact.flatten(1)
  end

  def piece_by_coordinates(coordinates_array)
    pieces.select{|piece| piece.coordinates == coordinates_array}.first
  end

  def pieces_with_jumps
    pieces.select do |piece|
      piece.owner == player && piece.jumps_available.size > 0
    end
  end

  def set_pieces
    @pieces = []
    coordinates_hash.each do |coord, type|
      @pieces << Piece.new(self, coord, type) if type > 0
    end
  end

  def coordinates_hash
    hash = {}
    state.each_with_index {|row, y| row.each_with_index {|square, x| hash[[x, y].clone] = square.to_i}}
    hash
  end

  def find_piece_coordinates
    player == 0 ? coordinates_hash.select{|k,v| v == "1" || v == "3"} : hash.select{|k,v| v == "2" || v == "4"}
  end
end
