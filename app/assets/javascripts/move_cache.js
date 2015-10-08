function djBoard(){
  var boardArr = [["-1", "2", "-1", "0", "-1", "0", "-1", "2"], ["0", "-1", "0", "-1", "2", "-1", "2", "-1"], ["-1", "2", "-1", "0", "-1", "0", "-1", "0"], ["2", "-1", "2", "-1", "0", "-1", "0", "-1"], ["-1", "1", "-1", "0", "-1", "0", "-1", "0"], ["0", "-1", "0", "-1", "0", "-1", "0", "-1"], ["-1", "1", "-1", "1", "-1", "1", "-1", "2"], ["1", "-1", "1", "-1", "0", "-1", "1", "-1"]]

  Board.current().turn.player = Player.all[1];
  Board.current().player = Player.all[1];
  board = new Board(Board.current().turn);
  Board.displayBoardState(boardArr);
  board.getBoardState();

}

function tjBoard(){
  var boardArr = [["-1", "2", "-1", "2", "-1", "0", "-1", "2"], ["1", "-1", "1", "-1", "2", "-1", "2", "-1"], ["-1", "0", "-1", "0", "-1", "0", "-1", "2"], ["0", "-1", "0", "-1", "1", "-1", "0", "-1"], ["-1", "0", "-1", "1", "-1", "0", "-1", "0"], ["0", "-1", "0", "-1", "1", "-1", "1", "-1"], ["-1", "1", "-1", "0", "-1", "0", "-1", "0"], ["1", "-1", "1", "-1", "0", "-1", "0", "-1"]]
  Board.current().turn.player = Player.all[1];
  Board.current().player = Player.all[1];
  board = new Board(Board.current().turn);
  Board.displayBoardState(boardArr);
  board.getBoardState();
}

function setUpMove(){
  // debugger
  Board.all[Board.all.length - 1].sendToDatabase();
}
