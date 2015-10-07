function djBoard(){
  var boardArr = [["-1", "2", "-1", "0", "-1", "0", "-1", "2"], ["0", "-1", "0", "-1", "2", "-1", "2", "-1"], ["-1", "2", "-1", "0", "-1", "0", "-1", "0"], ["2", "-1", "0", "-1", "0", "-1", "0", "-1"], ["-1", "1", "-1", "0", "-1", "0", "-1", "0"], ["0", "-1", "0", "-1", "0", "-1", "0", "-1"], ["-1", "1", "-1", "1", "-1", "1", "-1", "2"], ["1", "-1", "1", "-1", "0", "-1", "1", "-1"]]
  // debugger
  Board.all[Board.all.length - 1].turn.player = Player.all[1];
  Board.all[Board.all.length - 1].player = Player.all[1];
  Board.all[0].displayBoardState(boardArr);
  Board.all[Board.all.length - 1].getBoardState();
  debugger
  // board.sendToDatabase();
}

function setUpMove(){
  debugger
  Board.all[Board.all.length - 1].sendToDatabase();
}
