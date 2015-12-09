class Snake

	gameWidth: null
	gameHeight: null

	path: []
	dir: { x: -1, y: 0 }

	constructor: (@gameWidth, @gameHeight) ->
		@place()

	place: ->
		startLength = 3
		row = Math.floor(Math.random() * (@gameHeight - (2 * startLength))) + startLength
		column = Math.floor(Math.random() * (@gameWidth - (2 * startLength))) + startLength
		@path.push { row: row, column: column }

		i = Math.floor(Math.random() * 3) - 1
		j = 0
		if i == 0
			j = 1
			if Math.floor(Math.random() * 2) == 1
				j = -1
		# i, j will be a direction
		# oposite to the direction we will be travelling
		@dir.x = -j
		@dir.y = -i

		# build snake in the opposite of our direction
		for k in [1...startLength]
			@path.push { row: @head().row + (i * k), column: @head().column + (j * k) }

	head: ->
		return @path[0]

	tail: ->
		return @path[@path.length - 1]

window.Snake = Snake