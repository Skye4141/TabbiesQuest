class_name MonsterArm extends Node2D

@export var integrity: int = 1
@export var damage: int = 1
@export var grabbiness: int = 0
@export var swifty: bool = false
@export var waschmack: bool = false
@export var splash: bool = false

@export var side: Monster.MonsterSide = Monster.MonsterSide.LEFT
@export var index: int = 0

@export var weaponPlacement: StaticBody2D
@export var weapon: MonsterWeapon
var monster: Monster

func attachArmEvents():
	pass

func destroyArm():
	var ownerSide: Array[MonsterArm] = (monster.LeftArms if side == Monster.MonsterSide.LEFT else monster.RightArms)
	ownerSide.erase(self)
	queue_free()

var _additionalEffectEnemies: Array[Enemy]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack(enemies: Array[Enemy]):
	_additionalEffectEnemies = dealDamage(enemies)
	if weapon:
		weapon.additionDamageEffects(_additionalEffectEnemies)

func dealDamage(enemies: Array[Enemy]) -> Array[Enemy]:
	if not enemies or enemies.size() == 0:
		return []
	var damagedEnemies: Array[Enemy] = []
	if splash:
		for enemy: Enemy in enemies:
			enemy.takeDamage(damage)
			damagedEnemies.append(enemy)
	elif waschmack:
		var remaining = damage
		for enemy: Enemy in enemies:
			if remaining > 0:
				var temp = remaining - enemy.health
				enemy.takeDamage(remaining)
				remaining = temp
				damagedEnemies.append(enemy)
	else:
		enemies[0].takeDamage(damage)
		damagedEnemies.append(enemies[0])
	return damagedEnemies
	
func equipWeapon(newWeapon: MonsterWeapon):
	if not weapon.canEquip(self):
		return
	var container = get_child(1) as Node2D
	newWeapon.instantiate()
	container.add_child(newWeapon)
	weapon = newWeapon
	weapon.position = Vector2.ZERO
	weapon.equip(self)
