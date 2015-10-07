var Board = function(turn){
  this.turn = turn;
  this.turnNumber = turn.turnNumber;
  this.player = turn.player;
  this.getBoardState();
  Board.all.push(this);
}

Board.all = [];

Board.current = function(){
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

Board.displayBoardState = function(boardState){
  Piece.all = [];
  var newBoard = boardState.map(function(row, y){
    row.map(function(square, x){
      var squareToUpdate = Square.findByPosition(x, y);
      if(square == 3 || square == 1){
        var p1Piece = new Piece(Player.all[0])
        if(square == 3){
          p1Piece.kingMe()
        }
        p1Piece.goToSquare(squareToUpdate);
      } else if(square == 4 || square == 2){
        var p2Piece = new Piece(Player.all[1])
        if(square == 4){
          p2Piece.kingMe()
        }
        p2Piece.goToSquare(squareToUpdate);
      } else if(square == 0){
        if(squareToUpdate.piece){
          squareToUpdate.piece.leaveSquare();
        }
      }
    })
  })
}

Board.prototype.sendToDatabase = function(){
  var _that = this
  $.ajax({
    method: "POST",
    url: "/boards",
    data: {
      state: this.boardState,
      turn: this.turnNumber,
      player: Player.all.indexOf(this.player)
    }
  }).done(function(message){
    var msg = JSON.parse(message)
    var msgCount = msg.length

    var interval = setInterval(function(){
      Board.displayBoardState(msg.shift());
      if (!msg.length) {
        clearInterval(interval);
        _that.turn.end();
      }
    }, 3000)

    // msg.forEach(function(move){
    //   setTimeout(function(){
    //     _that.displayBoardState(move)
    //     // msgCount -= 1
    //     // if (msgCount == 0) { _that.turn.end(); }
    //   }, 1000)
    //   setTimeout(function(){
    //     _that.turn.end();
    //   }, (1000*msgCount)+1000)
    // })
  })
}
