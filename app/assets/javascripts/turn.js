var Turn = function(player){
  this.player = player;
  this.choosePieceListener();
}

Turn.prototype.choosePieceListener = function(){
  $("." + this.player.name + ".piece").on('click', this, function(e){
    var turn = e.data
    e.stopPropagation();
    $('.piece').off();

    if ($(".selected").length == 0){
      var piece = Piece.findOnClick(this);
      piece.toggleHighlight();
      $(this).parent().toggleClass("selected");
      turn.squareChoiceListener(piece, turn);
    }
  });
}

Turn.prototype.squareChoiceListener = function(piece, turn){
  $('.on').on('click', {piece: piece, turn: turn}, function(e){
    var piece = e.data.piece;
    var turn = e.data.turn;
    e.stopPropagation();
    $('.on').off();
    if($(this).hasClass('selected')){
      piece.toggleHighlight();
      $(this).toggleClass('selected');
      piece.player.takesTurn();
    } else if ($(this).hasClass("highlighted")){
      piece.jumpOrSlide(Square.findByJSquare($(this)));
      $('.selected').toggleClass('selected');
      turn.checkWin();
      piece.player.opponent.takesTurn();
    } else if ($(this).hasClass("on")){
      turn.squareChoiceListener(piece, turn);
    }
  });
}

Turn.prototype.checkWin = function () {
  if(this.player.opponent.pieces().length === 0){
    alert('YOU WON');
  }
};
