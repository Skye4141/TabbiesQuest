class_name Enemy extends Node2D



#base stats modifiable by editor
@export var baseSpeed: int = 1
@export var baseHealth: int = 1
@export var baseDamage: int = 1
var onFire: bool = false

#current stats
var speed: int
var health: int
var damage: int

#lane tracking
var laneGroup: Lane.LaneGroup = Lane.LaneGroup.STAGING
var lanePos: Lane.LanePosition = Lane.LanePosition.MIDDLE

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = baseSpeed
	health = baseHealth
	damage = baseDamage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func endOfTurnEffects():
	if onFire:
		takeDamage(1)

func getDamage():
	return damage
	
func takeDamage(dmg: int):
	health -= dmg
	if health <= 0:
		die()
		

		
func die():
	queue_free()
	
func setStartingLanePos():
	lanePos = randi() % 3
