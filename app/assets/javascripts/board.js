var Board = function(turn){
  this.turn = turn;
  this.turnNumber = turn.turnNumber;
  this.player = turn.player;
  this.getBoardState();
  Board.all.push(this);
}

Board.all = [];

Board.currentBoard = function(){
  return Board.all[Board.all.length - 1]
}

// [0 = empty, 1= p1, 2= p2, 3= p1King, 4= p2King, -1= off-square]

Board.prototype.getBoardState = function(){
  var segmentedBoard = [];
  var unsegmentedBoard = this.getUnsegmentedBoard();
  for(var i=0; i<8; i++){
    segmentedBoard.push(unsegmentedBoard.splice(0,8));
  }
  this.boardState = segmentedBoard;
};

// Board.prototype.imagineFutureBoards

Board.prototype.getUnsegmentedBoard = function(){
  return Square.all.map(function(square){
    if(square.color === "off"){
      return -1;
    } else if(square.piece === null){
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

Board.prototype.displayBoardState = function(boardState){
  Piece.all = [];
  var newBoard = boardState.map(function(row, y){
    row.map(function(square, x){
      var squareToUpdate = Square.findByPosition(x, y);
      if(square == 3 || square == 1){
        new Piece(Player.all[0]).goToSquare(squareToUpdate);
      } else if(square == 4 || square == 2){
        new Piece(Player.all[1]).goToSquare(squareToUpdate);
      } else if(square == 0){
        if(squareToUpdate.piece){
          squareToUpdate.piece.leaveSquare();
        }
      }
    })
  })
}

Board.prototype.sendToDatabase = function(){
  $.ajax({
    method: "POST",
    url: "/boards",
    data: {
      state: this.boardState,
      turn: this.turnNumber,
      player: Player.all.indexOf(this.player)
    }
  }).done(function(message){
    this.displayBoardState(JSON.parse(message));
    // debugger
    this.turn.end();
  }.bind(this))
  this.player.opponent.takesTurn()
}
