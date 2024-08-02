class_name Util extends Node2D

static var _game: Game

static func getRandomDictEntry(dict: Dictionary):
	var size = dict.size()
	var random_key = dict.keys()[randi() % size]
	var entry = dict[random_key]
	return entry
	
static func wait(seconds: float):
	OS.delay_msec(seconds * 1000)

static func showCanvasLayer(node: CanvasLayer):
	for child in node.get_children():
		if false and child is CanvasLayer:
			showCanvasLayer(child)
		else:
			child.show()

static func hideCanvasLayer(node: CanvasLayer):
	for child in node.get_children():
		if false and child is CanvasLayer:
			hideCanvasLayer(child)
		else:
			child.hide()
			
static func game() -> Game:
	return _game
	
static func setGame(newGame: Game):
	_game = newGame
