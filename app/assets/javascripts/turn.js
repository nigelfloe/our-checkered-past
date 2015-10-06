var Turn = function(player){
  updateInfoPanel(player);
  this.player = player;
  this.player.turn = this;
  this.choosePieceListener();
  Turn.all.push(this);
  this.turnNumber = Turn.all.length;
  this.board = new Board(this);
}

Turn.all = [];

Turn.prototype.checkStalemate = function(){
  var piecesWithMoves = this.player.pieces.filter(function(piece){
    return piece.legalMoves().length > 0
  })
  if(piecesWithMoves.length == 0 && Turn.all.length > 1){
    // alert("Draw");
  }
}

Turn.prototype.choosePieceListener = function(){
  $("." + this.player.name + ".piece").on('click', this, function(e){
    $('.piece').off();
    e.stopPropagation();
    var turn = e.data

    if ($(".highlighted").length == 0){
      var piece = Piece.findOnClick(this);
      piece.square.jSquare().toggleClass('selected');
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
    // deselect piece
    $('.selected').toggleClass('selected');
    if(Square.findByJSquare($(this)).piece == piece){
      piece.toggleHighlight();
      turn.choosePieceListener();
    } else {
      piece.jumpOrSlide(Square.findByJSquare($(this)));
    }
  });
}

Turn.prototype.end = function(){
  this.checkWin();
  this.checkStalemate();
  // this.board.sendToDatabase();
  this.player.opponent.takesTurn();
};

Turn.prototype.checkWin = function(){
  if(this.player.opponent.pieces.length === 0){
    alert('YOU WON');
  }
};
