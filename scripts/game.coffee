->
class Game

	cellSize: 16
	numberOfRows: 50 #50
	numberOfColumns: 80 #80
	tickLength: 100
	canvas: null
	drawingContext: null

	grid: null
	snack: null
	snake: null

	tail: {
		row: null
		column: null
	}

	running: null

	player: null

	player_type = 0

	constructor: ->

	run: ->
	    @running = false

		# init canvas
	    @createCanvas()
	    @resizeCanvas()
	    @createDrawingContext()

	    # init game state
	    @initGrid()
	    @initSnack()
	    @initSnake()

	    @initPlayer(0)

	    @draw()
	    # main game loop

	startGame: ->
		@running = true
		@gameLoop()
		$('.overlay').hide()

	endGame: ->
		window.removeEventListener("keydown", @doKeyDown, true)
		console.log "event listener removed"
		@running = false
		$('.header').text("You Lost")
		$('.sub-header').text("score: " + @snake.path.length)
		$('.overlay').show()
	
	gameLoop: ->
		# Do game logic
		@draw()
		
		@makeMove(@snake.dir.x, @snake.dir.y)

		copy = @copyGameState(@grid)
		move = @player.move(copy, @snake.head(), { row: @snack.row, column: @snack.column })
		if move != undefined
			@makeMove(move.x, move.y)

		setTimeout(=> 
			@gameLoop()
		, @tickLength)

	copyGameState: (state) ->
		return JSON.parse(JSON.stringify(state))

	makeMove: (x, y) ->
		if x >= -1 and x <= 1
			if y >= -1 and y <= 1
				if !(x == y == 0)
					newY = @snake.head().row + y
					newX = @snake.head().column + x
					newY = ((newY % @numberOfRows) + @numberOfRows) % @numberOfRows
					newX = ((newX % @numberOfColumns) + @numberOfColumns) % @numberOfColumns
					if @grid[newY][newX].isSnake == false
						if !@grid[newY][newX].isSnack
							# move by adding head and removing tail
							@grid[@snake.tail().row][@snake.tail().column].isSnake = false
							@snake.path.pop()
						else
							# hit the snack!
							# replace snack
							@grid[@snack.row][@snack.column].isSnack = false
							@snack.place()
							@grid[@snack.row][@snack.column].isSnack = true
							@tickLength = Math.round(@tickLength / 1.1)
						@grid[newY][newX].isSnake = true
						@snake.path.unshift { row: newY, column: newX }
						@snake.dir = { x: x, y: y }
					else if not (x * -1 == @snake.dir.x && y * -1 == @snake.dir.y)
						# hit ourselves
						@endGame()

	draw: ->
		for row in [0...@numberOfRows]
			for column in [0...@numberOfColumns]
				@drawCell @grid[row][column]

	drawCell: (cell) ->
		x = cell.column * @cellSize
		y = cell.row * @cellSize

		if cell.isSnack
			fillStyle = 'rgb(242, 95, 65)'
		else if cell.isSnake
			fillStyle = 'rgb(138, 250, 50)'
		else
			fillStyle = 'rgb(50, 50, 50)'

		@drawingContext.strokeStyle = 'rgba(255, 255, 255, 0)'
		@drawingContext.strokeRect x, y, @cellSize, @cellSize

		@drawingContext.fillStyle = fillStyle
		@drawingContext.fillRect x, y, @cellSize, @cellSize

	createCanvas: ->
	    @canvas = document.createElement 'canvas'
	    @canvas.id = "canvas"
	    @canvas.width = @cellSize * @numberOfColumns
	    document.body.appendChild @canvas

	resizeCanvas: ->
		@canvas.height = @cellSize * @numberOfRows
		@canvas.width = @cellSize * @numberOfColumns

	createDrawingContext: ->
		@drawingContext = @canvas.getContext '2d'

	initGrid: ->
		@grid = []

		for row in [0...@numberOfRows]
	    	@grid[row] = []

	    	for column in [0...@numberOfColumns]
	    		@grid[row][column] = @createCell row, column

	createCell: (row, column) ->
		isSnake: false
		isSnack: false
		row: row
		column: column

	initSnack: ->
		@snack = new Snack(@numberOfColumns, @numberOfRows)
		@grid[@snack.row][@snack.column].isSnack = true

	initSnake: ->
		@snake = new Snake(@numberOfColumns, @numberOfRows)
		for cell in @snake.path
			@grid[cell.row][cell.column].isSnake = true

	initPlayer: (type) ->
		switch type
			when 0
				@player = new Player()
			when 1
				@player = new Computer()
				@startGame()

window.Game = Game