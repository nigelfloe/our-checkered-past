class Board < ActiveRecord::Base
  attr_reader :coordinates_hash
  validates_presence_of :state, :player
  serialize :state

# v % 2 != 0

  def find_piece_coordinates
    player == 0 ? coordinates_hash.select{|k,v| v == "1" || v == "3"} : hash.select{|k,v| v == "2" || v == "4"}
  end

  def coordinates_hash
    hash = {}
    state.each_with_index {|row, y| row.each_with_index {|square, x| hash[[x, y].clone] = square.to_i}}
    hash
  end

  # def pieces_with_jumps
  #
  # end


  # Piece.piecesWithJumps = function(player){
  #   return Piece.all.filter(function(piece){
  #     return piece.jumpsAvailable().length > 0 && player == piece.player;
  #   });
  # };
  #
  # Piece.prototype.jumpsAvailable = function(){
  #   return this.jumps.filter(function(jump, index){
  #     return this.slides[index] && !this.slides[index].empty() && (this.slides[index].piece.player == this.player.opponent) && jump && jump.empty()
  #   }.bind(this))
  # }
  #
  #   Piece.prototype.legalMoves = function(){
  #     if (Piece.piecesWithJumps(this.player).length > 0 && Piece.piecesWithJumps(this.player).indexOf(this) < 0){
  #       return []
  #     } else if(this.jumpsAvailable().length > 0){
  #       return this.jumpsAvailable();
  #     } else {
  #       return this.slides.filter(function(slide){
  #         return !!slide && slide.empty();
  #       });
  #     }
  #   };
  # Piece.prototype.setSlides = function(){
  #   this.slides = [];
  #   if(this.player.name == 'p1' || this.isKing){
  #     this.slides.push(Square.findByPosition(this.square.positionX - 1, this.square.positionY - 1));
  #     this.slides.push(Square.findByPosition(this.square.positionX + 1, this.square.positionY - 1));
  #   }
  #   if(this.player.name == 'p2' || this.isKing){
  #     this.slides.push(Square.findByPosition(this.square.positionX - 1, this.square.positionY + 1));
  #     this.slides.push(Square.findByPosition(this.square.positionX + 1, this.square.positionY + 1));
  #   }
  # }
  #
  # Piece.prototype.setJumps = function(){
  #   this.jumps = [];
  #   if(this.player.name == 'p1' || this.isKing){
  #     this.jumps.push(Square.findByPosition(this.square.positionX - 2, this.square.positionY - 2));
  #     this.jumps.push(Square.findByPosition(this.square.positionX + 2, this.square.positionY - 2));
  #   }
  #   if(this.player.name == 'p2' || this.isKing){
  #     this.jumps.push(Square.findByPosition(this.square.positionX - 2, this.square.positionY + 2));
  #     this.jumps.push(Square.findByPosition(this.square.positionX + 2, this.square.positionY + 2));
  #   }
  # }

end
