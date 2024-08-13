class_name Game extends Node2D

var combatScene: PackedScene = preload("res://combat/combat1.tscn")
var combat: Combat

func _on_debug_start_combat_pressed():
	startCombat()
	

func startCombat():
	combat = combatScene.instantiate()
	add_child(combat)
	combat.game = self
	get_node("%MainMenu").hide()

func gameOver():
	get_node("%DefeatScreen").show()
	await get_tree().create_timer(5.0).timeout
	if (combat):
		combat.queue_free()
	get_node("%DefeatScreen").hide()
	get_node("%MainMenu").show()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	Util.setGame(self)
	get_node("%DefeatScreen").hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func on_():
	pass # Replace with function body.
