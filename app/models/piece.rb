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
      on_board?(slides[index]) && is_empty?(slides[index]) && is_opponent_piece?(slides[index]) && on_board?(jump) && !board.piece_by_coordinates(jump)
    end
  end

  def is_opponent_piece?(coordinates)
    !!(opponent_pieces.include?(is_empty?(coordinates).type))
  end

  def on_board?(coordinates)
    !!(coordinates[0] > -1 && coordinates[0] < 8 && coordinates[1] > -1 && coordinates[1] < 8)
  end

  def is_empty?(coordinates_array)
    board.piece_by_coordinates(coordinates_array)
  end

  def legal_moves
    if board.pieces_with_jumps.include?(self)
      return jumps_available.map{|jump| [coordinates, jump]}
    elsif board.pieces_with_jumps.empty?
      return slides.select{|slide| on_board?(slide) && !is_empty?(slide)}.map do |slide|
        [coordinates, slide]
      end
    else
      return []
    end
  end


end
