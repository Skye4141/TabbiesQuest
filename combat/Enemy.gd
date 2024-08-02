class_name Enemy extends Node2D



#base stats modifiable by editor
@export var baseSpeed: int = 1
@export var baseHealth: int = 1
@export var baseDamage: int = 1
@export var lane: Lane
@export var healthLabel: Label
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
	healthLabel.text = str(baseHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func endOfTurnEffects():
	if onFire:
		takeDamage(1)

func getDamage():
	return damage
	
func takeDamage(dmg: int):
	health -= dmg
	healthLabel.text = str(health)
	if health <= 0:
		die()
		

		
func die():
	lane.enemies.erase(self)
	queue_free()
	
func setStartingLanePos():
	lanePos = (randi() % 3) as Lane.LanePosition
