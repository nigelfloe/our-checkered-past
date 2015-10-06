class Piece
  attr_accessor :board, :coordinates

  def initialize(board, coordinates, type)
    @board = board
    @coordinates = coordinates
    @type = type
  end

  def opponent_pieces
    board.player == 0 ? [2, 4] : [1, 3]
  end

  def slides
    arr = []
    if player == 0 || board.coordinates_hash[coordinates] > 2
      arr << [coordinates[0] - 1, coordinates[1] - 1]
      arr << [coordinates[0] + 1, coordinates[1] - 1]
    end
    if player == 1 || board.coordinates_hash[coordinates] > 2
      arr << [coordinates[0] - 1, coordinates[1] + 1]
      arr << [coordinates[0] + 1, coordinates[1] + 1]
    end
    arr
  end

  def jumps
    arr = []
    if player == 0 || board.coordinates_hash[coordinates] > 2
      arr << [coordinates[0] - 2, coordinates[1] - 2]
      arr << [coordinates[0] + 2, coordinates[1] - 2]
    end
    if player == 1 || board.coordinates_hash[coordinates] > 2
      arr << [coordinates[0] - 2, coordinates[1] + 2]
      arr << [coordinates[0] + 2, coordinates[1] + 2]
    end
    arr
  end

  # def legal_moves
  #
  # end

  def jumps_available
    jumps.select.with_index do |jump, index|
      slides[index] && slides[index] > 0 && (opponent_pieces.include?(slides[index])) && jump && jump == 0
    end
  end

  # Piece.prototype.jumpsAvailable = function(){
  #   return this.jumps.filter(function(jump, index){
  #     return this.slides[index] && !this.slides[index].empty() && (this.slides[index].piece.player == this.player.opponent) && jump && jump.empty()
  #   }.bind(this))
  # }
end
