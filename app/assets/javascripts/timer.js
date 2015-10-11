// var Timer = function(){
//   this.startingTime = new Date().getTime();
//   this.counter = 60;
// }

var startingTime = new Date().getTime();
var countFrom = 60;
var countDown = function(){
  var currentTime = new Date().getTime();
  var diff = currentTime - startingTime;
  var secondsLeft = countFrom - Math.floor(diff/1000);
  if(secondsLeft >= 0){
    $('.timer').html("<h3>00:" + secondsLeft + "</h3>");
  } else {
    $('.timer').html("<h3>TIME UP</h3>");
    clearInterval(count);
  }
}
//
// Timer.prototype.countDown = function() {
//   debugger;
//   this.currentTime = new Date().getTime();
//   this.diff = this.currentTime - this.startingTime;
//   this.secondsLeft = this.counter - Math.floor(this.diff/1000);
//   debugger;
//   if(this.secondsLeft >= 0){
//     $('.timer').html("<h3>00:" + this.secondsLeft + "</h3>");
//     debugger;
//   } else {
//     debugger;
//     $('.timer').html("<h3>TIME UP</h3>");
//     clearInterval(this.updateCounter());
//   }
// };
//
// Timer.prototype.updateCounter = function() {
//   var timer = this;
//   setInterval(timer.countDown(), 1000);
// }
