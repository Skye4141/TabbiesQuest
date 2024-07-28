extends TextureButton

var start_button
# Called when the node enters the scene tree for the first time.
func _ready():
	#start_button = get_node("StartButton")
	#start_button.show() # Replace with function body.
	get_node("%Combat").hideCombat()

func _on_start_pressed():
	#self.hide()
	print("button pressed")
	#get_tree().change_scene_to_file("res://overworld.tscn")
	get_node("%MainMenu").hide()
	#get_node("%Combat").show()
	var combat = get_node("%Combat")
	combat.showCombat()
	combat.position += Vector2(500, 500)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
