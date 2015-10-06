class Piece
  attr_reader :type, :owner
  attr_accessor :board, :coordinates

  def initialize(board, coordinates, type)
    @board = board
    @coordinates = coordinates
    @type = type
    @owner = set_owner
  end

  def set_owner
    type % 2 == 0 ? 1 : 0
  end

  def is_king?
    !!(type > 2)
  end

  def opponent_pieces
    owner == 0 ? [2, 4] : [1, 3]
  end

  def slides
    arr = []
    if owner == 0 || is_king?
      arr << [coordinates[0] - 1, coordinates[1] - 1]
      arr << [coordinates[0] + 1, coordinates[1] - 1]
    end
    if owner == 1 || is_king?
      arr << [coordinates[0] - 1, coordinates[1] + 1]
      arr << [coordinates[0] + 1, coordinates[1] + 1]
    end
    arr
  end

  def jumps
    arr = []
    if owner == 0 || board.coordinates_hash[coordinates] > 2
      arr << [coordinates[0] - 2, coordinates[1] - 2]
      arr << [coordinates[0] + 2, coordinates[1] - 2]
    end
    if owner == 1 || board.coordinates_hash[coordinates] > 2
      arr << [coordinates[0] - 2, coordinates[1] + 2]
      arr << [coordinates[0] + 2, coordinates[1] + 2]
    end
    arr
  end

  def jumps_available
    jumps.select.with_index do |jump, index|
      binding.pry
      on_board?(slides[index]) && board.piece_by_coordinates(slides[index]) && is_opponent_piece?(slides[index]) && on_board?(jump) && !board.piece_by_coordinates(jump)
    end
  end

  def is_opponent_piece?(coordinates)
    !!(opponent_pieces.include?(board.piece_by_coordinates(coordinates).type))
  end

  def on_board?(coordinates)
    !!(coordinates[0] > -1 && coordinates[0] < 8 && coordinates[1] > -1 && coordinates[1] < 8)
  end


  def legal_moves

  end

end
