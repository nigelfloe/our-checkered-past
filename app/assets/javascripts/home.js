$(document).ready(function(){
  renderBoard();

});

function renderBoard(){
  $(".red-first").html(renderRow("red"));
  $(".black-first").html(renderRow("black"));
  $.makeArray($(".square")).forEach(function(square, index){
    $(square).attr('id', index)
  });
}

function renderSquare(color){
  return "<div class='" + color + " square'></div>"
}

function renderRow(firstColor){
  var row = "";
  if(firstColor === "red"){
    for(var i=0; i<4; i++){
      row = row + renderSquare("red") + renderSquare("black");
    }
  } else if(firstColor === "black"){
    for(var i=0; i<4; i++){
      row = row + renderSquare("black") + renderSquare("red");
    }
  }
  return row;
}
