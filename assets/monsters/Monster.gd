class_name Monster extends Node2D

enum MonsterSide {LEFT, RIGHT}
@export var LeftArms: Array[MonsterArm] = [null, null, null, null]
@export var RightArms: Array[MonsterArm] = [null, null, null, null]
@export var lane: Lane
@export var healthLabel: Label
@export var armorLabel: Label

@export var baseHealth: int = 10
@export var baseArmor: int = 0

var LeftArmSlots: int = 2
var RightArmSlots: int = 2
var onFire: bool = false

var testArmScene = preload("res://combat/arms/claw.tscn")

@export var leftArm0Placement: StaticBody2D
@export var leftArm1Placement: StaticBody2D
@export var leftArm2Placement: StaticBody2D
@export var leftArm3Placement: StaticBody2D
@export var rightArm0Placement: StaticBody2D
@export var rightArm1Placement: StaticBody2D
@export var rightArm2Placement: StaticBody2D
@export var rightArm3Placement: StaticBody2D


func getArmPlacementFromPosition(side: MonsterSide, index: int) -> StaticBody2D:
	match side:
		MonsterSide.LEFT:
			match index:
				0:
					return leftArm0Placement
				1:
					return leftArm1Placement
				2:
					return leftArm2Placement
				3:
					return leftArm3Placement
		MonsterSide.RIGHT:
			match index:
				0:
					return rightArm0Placement
				1:
					return rightArm1Placement
				2:
					return rightArm2Placement
				3:
					return rightArm3Placement
	return null
					

func attachArm(armScene: PackedScene, side: MonsterSide, index: int):
	var newArm: MonsterArm = armScene.instantiate()
	var armPlacement: StaticBody2D = getArmPlacementFromPosition(side, index)
	var armGroup: Array[MonsterArm] = LeftArms if side == MonsterSide.LEFT else RightArms
	if armGroup[index]:
		armGroup[index].destroyArm()
	#TODO: validate if arm can be added at that index
	
	armPlacement.add_child(newArm)
	newArm.monster = self
	newArm.side = side
	newArm.index = index
	armGroup[index] = newArm
	if side == MonsterSide.RIGHT:
		newArm.horizontalFlip()
	newArm.attachArmEvents()

#current stats
@export var Health: IntField
@export var Armor: IntField

func takeDamage(amount: int):
	Health.Change(amount * -1)
	if Health.Get() <= 0:
		Util.game().gameOver()
	
func heal(amount: int):
	Health.change(amount)

	
func endOfTurnEffects():
	pass
	
func dealDamage(enemies: Array[Enemy]):
	for arm: MonsterArm in LeftArms:
		if arm:
			arm.dealDamage(enemies)
	enemies.reverse()
	for arm: MonsterArm in RightArms:
		if arm:
			arm.dealDamage(enemies)

# Called when the node enters the scene tree for the first time.
func _ready():
	Health.Set(baseHealth)
	Health.maxValue = baseHealth
	Armor.Set(baseArmor)
	attachArm(testArmScene, MonsterSide.LEFT, 0)
	#attachArm(testArmScene, MonsterSide.RIGHT, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
