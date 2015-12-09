class Snack

	gameWidth: null
	gameHeight: null

	row: null
	column: null

	constructor: (@gameWidth, @gameHeight) ->
		@place()

	place: ->
		@row = Math.floor(Math.random() * @gameHeight)
		@column = Math.floor(Math.random() * @gameWidth)

window.Snack = Snack