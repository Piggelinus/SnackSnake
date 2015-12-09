class Player
	constructor: ->
	    window.addEventListener("keydown", @doKeyDown, true);

	move: (grid, snake, snack) ->

	doKeyDown: (e) =>
		if game.running == false
			game.startGame()
		if e.keyCode == 37
			game.makeMove(-1, 0)
		if e.keyCode == 38
			game.makeMove(0, -1)
		if e.keyCode == 39
			game.makeMove(1, 0)
		if e.keyCode == 40
			game.makeMove(0, 1)

window.Player = Player