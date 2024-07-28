class_name Monster extends AnimatedSprite2D

enum MonsterSide {LEFT, RIGHT}
@export var LeftArms: Array[MonsterArm]
@export var RightArms: Array[MonsterArm]

@export var baseHealth: int = 1

var onFire: bool = false

#current stats
var health: int 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
