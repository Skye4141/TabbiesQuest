class_name MonsterWeapon extends Node

@export var arm: MonsterArm
@export var weight: int
@export var damageModifier: int
@export var durability: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func additionDamageEffects(enemies: Array[Enemy]):
	degrade()
	
func degrade(amount: int = 1):
	durability -= amount
	if durability <= 0:
		destroy()
		
func destroy():
	unequip()
	queue_free()
	
func canEquip(newArm: MonsterArm) -> bool:
	if weight > newArm.grabbiness:
		return false
	return true
	
func equip(newArm: MonsterArm):
	arm = newArm
	arm.damage += damageModifier
	
func unequip():
	arm.damage -= damageModifier
