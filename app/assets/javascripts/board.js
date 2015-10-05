var Board = function(turn){
  this.turnNumber = turn.turnNumber;
  this.player = turn.player;
  this.getBoardState();
  Board.all.push(this);
}

Board.all = [];

// [0 = empty, 1= p1, 2= p2, 3= p1King, 4= p2King]

Board.prototype.getBoardState = function() {
  var segmentedBoard = [];
  var unsegmentedBoard = this.getUnsegmentedBoard();
  for(var i=0; i<8; i++){
    segmentedBoard.push(unsegmentedBoard.splice(0,8));
  }
  this.boardState = segmentedBoard;
};

Board.prototype.getUnsegmentedBoard = function() {
  return Square.all.map(function(square){
    if(square.piece === null){
      return 0;
    } else if(square.piece.isKing && square.piece.player.name === 'p1'){
      return 3;
    } else if(square.piece.isKing && square.piece.player.name === 'p2'){
      return 4;
    } else if(square.piece.player.name === 'p1'){
      return 1;
    } else if(square.piece.player.name === 'p2'){
      return 2;
    }
  });
};
