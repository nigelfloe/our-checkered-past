var Square = function(color, positionX, positionY){
  this.color = color;
  this.positionX = positionX;
  this.positionY = positionY;
  Square.all.push(this);
};

Square.all = [];

Square.findByPosition = function(x, y){
  return Square.all.filter(function(square){
    return square.positionX == x && square.positionY == y;
  })

};


Square.prototype.render = function(){
  return "<div class='" + this.color + " square' position-x='" + this.positionX + "' position-y='" + this.positionY + "'></div>"
};
