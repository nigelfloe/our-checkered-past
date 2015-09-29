var Square = function(color, positionX, positionY){
  this.color = color;
  this.positionX = positionX;
  this.positionY = positionY;
  this.position = positionX + "," + positionY;
  this.piece = null;
  Square.all.push(this);
};

Square.all = [];

Square.findByPosition = function(x, y){
  return Square.all.filter(function(square){
    return square.positionX == x && square.positionY == y;
  })[0]
};

Square.prototype.render = function(){
  // return "<div class='" + this.color + " square' position='" + this.position + "'></div>"
  return "<div class='" + this.color + " square' x='" + this.positionX + "' y='" + this.positionY + "' position='" + this.position + "'></div>"
};

Square.prototype.hello = function () {
  this.html('k');
};

Square.prototype.jSquare = function () {
  return $("[position='" + this.position + "']");
};

Square.prototype.setPiece = function(piece) {
  this.piece = piece;
};
