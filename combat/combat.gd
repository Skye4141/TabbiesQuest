class_name Combat extends Node2D

@export var game: Game
@export var leftLane: Lane
@export var rightLane: Lane
var lanes: Array[Lane]

func hideCombat():
	for child in get_children():
		child.hide()
		
func showCombat():
	for child in get_children():
		child.show()
# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_children():
		var canvas: CanvasLayer = node as CanvasLayer
		if canvas:
			canvas.follow_viewport_enabled = true
	lanes.append(leftLane)
	leftLane.combat = self
	lanes.append(rightLane)
	rightLane.combat = self
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_end_turn():
	for lane: Lane in lanes:
		lane.endOfTurnEffects()
		lane.endTurn()
	pass # Replace with function body.
