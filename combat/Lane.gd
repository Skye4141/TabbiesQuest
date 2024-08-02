class_name Lane extends Node2D

@export var combat: Combat
@export var enemies: Array[Enemy]
@export var monster: Monster
enum LaneGroup {STAGING, MIDDLE, ATTACK}
enum LanePosition {LEFT, MIDDLE, RIGHT}
static func getLaneCoords(laneGroup: LaneGroup, lanePos: LanePosition) -> Vector2i:
	var laneMap = {
		LaneGroup.STAGING: 2,
		LaneGroup.MIDDLE: 7,
		LaneGroup.ATTACK: 12
	}
	var LanePosMap = {
		LanePosition.LEFT: 2,
		LanePosition.MIDDLE: 5,
		LanePosition.RIGHT: 8
	}
	var y: int = laneMap[laneGroup]
	var x: int = LanePosMap[lanePos]
	return Vector2i(x, y)
	
const availableEnemyScenes = {
	"Puncher": preload("res://combat/enemies/puncher.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnEnemy()
	monster.lane = self
	#new_enemy.position = map_to_local(Vector2i(1,1))
#	new_enemy.scale = Vector2i(100, 100)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func getLanePosVectorFromEnemy(enemy: Enemy) -> Vector2i:
	return Lane.getLaneCoords(enemy.laneGroup, enemy.lanePos)
	
func endTurn():
	moveEnemies()
	doCombat()
	spawnEnemy()
	
func spawnEnemy():
	var enemyNode = Util.getRandomDictEntry(availableEnemyScenes)
	var newEnemy: Enemy = enemyNode.instantiate()
	newEnemy.setStartingLanePos()
	if findEnemyByLane(newEnemy.laneGroup, newEnemy.lanePos):
		newEnemy.queue_free()
	else:
		getEnemyLaneObj().add_child(newEnemy)
		moveEnemy(newEnemy)
		enemies.append(newEnemy)
		newEnemy.lane = self

func getEnemyLaneObj() -> TileMap:
	return get_child(0) as TileMap
	
func moveEnemy(enemy: Enemy) -> void:
	enemy.position = getEnemyLaneObj().map_to_local(getLanePosVectorFromEnemy(enemy))
	
func findEnemyByLane(laneGroup: LaneGroup, lanePos: LanePosition) -> Enemy:
	for enemy: Enemy in enemies:
		if enemy and enemy.laneGroup == laneGroup and enemy.lanePos == lanePos:
			return enemy
	return null

func moveEnemyForward(enemy: Enemy) -> void:
	var newLaneGroup = enemy.laneGroup + enemy.speed
	if newLaneGroup > 2:
		newLaneGroup = 2
	if not findEnemyByLane(newLaneGroup, enemy.lanePos):
		enemy.laneGroup = newLaneGroup as Lane.LaneGroup
		moveEnemy(enemy)
	
func moveEnemies():
	for enemy: Enemy in enemies:
		if enemy:
			moveEnemyForward(enemy)
			
func endOfTurnEffects():
	for enemy: Enemy in enemies:
		if enemy:
			enemy.endOfTurnEffects()
			
func getEnemiesInLaneGroup(laneGroup: LaneGroup) -> Array[Enemy]:
	var ret: Array[Enemy] = []
	for enemy: Enemy in enemies:
		if enemy and enemy.laneGroup == laneGroup:
			ret.append(enemy)
	return ret
	
func getAllMeleeEnemies() -> Array[Enemy]:
	return getEnemiesInLaneGroup(LaneGroup.ATTACK)
			
func doCombat():
	var combatEnemies = getAllMeleeEnemies()
	if combatEnemies.size() == 0:
		return
	for enemy: Enemy in combatEnemies:
		monster.takeDamage(enemy.getDamage())
	monster.dealDamage(combatEnemies)
	
	
	
