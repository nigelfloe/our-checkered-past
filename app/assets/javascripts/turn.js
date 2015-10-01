var Turn = function(player){
  this.player = player;
  this.checkStalemate();
  this.choosePieceListener();
}

Turn.prototype.checkStalemate = function(){
  var piecesWithMoves = this.player.pieces().filter(function(piece){
    return piece.legalMoves().length > 0
  })
  if(piecesWithMoves.length == 0){
    alert("Draw");
  }
}

Turn.prototype.choosePieceListener = function(){
  $("." + this.player.name + ".piece").on('click', this, function(e){
    $('.piece').off();
    e.stopPropagation();
    var turn = e.data

    if ($(".highlighted").length == 0){
      var piece = Piece.findOnClick(this);
      piece.toggleHighlight();
      turn.squareChoiceListener(piece, turn);
    }
  });
}

Turn.prototype.squareChoiceListener = function(piece, turn){
  $('.highlighted').on('click', {piece: piece, turn: turn}, function(e){
    $('.highlighted').off();
    e.stopPropagation();
    var piece = e.data.piece;
    var turn = e.data.turn;
    if(Square.findByJSquare($(this)).piece == piece){
      piece.toggleHighlight();
      piece.player.takesTurn();
    } else {
      piece.jumpOrSlide(Square.findByJSquare($(this)));
      turn.checkWin();
      piece.player.opponent.takesTurn();
    }
  });
}

Turn.prototype.checkWin = function () {
  if(this.player.opponent.pieces().length === 0){
    alert('YOU WON');
  }
};
