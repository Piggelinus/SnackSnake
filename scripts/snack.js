// Generated by CoffeeScript 1.8.0
var Snack;

Snack = (function() {
  Snack.prototype.gameWidth = null;

  Snack.prototype.gameHeight = null;

  Snack.prototype.row = null;

  Snack.prototype.column = null;

  function Snack(gameWidth, gameHeight) {
    this.gameWidth = gameWidth;
    this.gameHeight = gameHeight;
    this.place();
  }

  Snack.prototype.place = function() {
    this.row = Math.floor(Math.random() * this.gameHeight);
    return this.column = Math.floor(Math.random() * this.gameWidth);
  };

  return Snack;

})();

window.Snack = Snack;