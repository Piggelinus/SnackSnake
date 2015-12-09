// Generated by CoffeeScript 1.8.0
var Snake;

Snake = (function() {
  Snake.prototype.gameWidth = null;

  Snake.prototype.gameHeight = null;

  Snake.prototype.path = [];

  Snake.prototype.dir = {
    x: -1,
    y: 0
  };

  function Snake(gameWidth, gameHeight) {
    this.gameWidth = gameWidth;
    this.gameHeight = gameHeight;
    this.place();
  }

  Snake.prototype.place = function() {
    var column, i, j, k, row, startLength, _i, _results;
    startLength = 3;
    row = Math.floor(Math.random() * (this.gameHeight - (2 * startLength))) + startLength;
    column = Math.floor(Math.random() * (this.gameWidth - (2 * startLength))) + startLength;
    this.path.push({
      row: row,
      column: column
    });
    i = Math.floor(Math.random() * 3) - 1;
    j = 0;
    if (i === 0) {
      j = 1;
      if (Math.floor(Math.random() * 2) === 1) {
        j = -1;
      }
    }
    this.dir.x = -j;
    this.dir.y = -i;
    _results = [];
    for (k = _i = 1; 1 <= startLength ? _i < startLength : _i > startLength; k = 1 <= startLength ? ++_i : --_i) {
      _results.push(this.path.push({
        row: this.head().row + (i * k),
        column: this.head().column + (j * k)
      }));
    }
    return _results;
  };

  Snake.prototype.head = function() {
    return this.path[0];
  };

  Snake.prototype.tail = function() {
    return this.path[this.path.length - 1];
  };

  return Snake;

})();

window.Snake = Snake;
