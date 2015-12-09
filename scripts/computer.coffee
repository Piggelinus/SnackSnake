class Computer
	constructor: ->

	move: (grid, snake, snack) ->
		return @findPath(grid, snake, snack)
		
	findPath: (grid, start, goal) ->

		console.log start

		fringe = PriorityQueue()

		for a in @neighbours(grid, start, goal, 0, new Array())
			fringe.push a.priority, a.value1, a.value2

		while fringe.size() > 0
			node = fringe.pop()
			priority = node.priority
			current = node.value1
			path = node.value2
			console.log priority, current, path

			if current.row == goal.row and current.column == goal.column
				#console.log "goal reached: "
				#console.log current
				#console.log path
				return @direction(start, path[0])

			for a in @neighbours(grid, current, goal, priority, path)
				fringe.push a.priority, a.value1, a.value2

	neighbours: (grid, cell, goal, priority, path) ->
		neighbours = []
		for pos in [{ x: 0, y: -1 }, { x: 1, y: 0 }, { x: 0, y: 1 }, { x: -1, y: 0 }]
				neighbour = { row: cell.row - pos.y, column: cell.column - pos.x }
				if neighbour.row >= 0 and neighbour.row <= grid[0].length - 1
					if neighbour.column >= 0 and neighbour.column <= grid.length - 1
						p = @deepCopy(path)
						d = @distance(neighbour, goal)
						p.push grid[neighbour.row][neighbour.column]
						newPath = @deepCopy(p)
						neighbours.push {
							priority: priority + d,
							value1: grid[neighbour.row][neighbour.column],
							value2: newPath
						}
		return neighbours

	distance: (a, b) ->
		deltaX = a.column - b.column
		deltaY = a.row - b.row
		d = Math.sqrt(deltaX ** 2 + deltaY ** 2)
		return d

	direction: (from, to) ->
		return { x: from.column - to.column, y: from.row - to.row }

	deepCopy: (a) ->
		b = []
		for e in a
			f = {
				row: e.row,
				column: e.column,
				isSnake: e.isSnake,
				isSnack: e.isSnack
			}
			b.push f
		return b

window.Computer = Computer