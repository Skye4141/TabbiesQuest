class_name IntField extends Node2D

@export var sprite: Sprite2D
@export var label: Label
@export var startingValue: int = 0
var _value: int

@export var canBeNegative: bool = false
@export var maxValue: int = -1

func Set(amount: int):
	_value = amount
	if not canBeNegative and amount < 0:
		_value = 0
	if maxValue > -1 and amount > maxValue:
		_value = maxValue
	if label:
		label.text = str(_value)
	
func Get() -> int:
	return _value
	
func Change(amount: int):
	Set(_value + amount)
	
func Reduce(amount: int):
	Change(-1 * amount)


# Called when the node enters the scene tree for the first time.
func _ready():
	if not sprite:
		sprite = get_child(0)
	if not label:
		label = get_child(1)
	if startingValue > 0:
		Set(startingValue)

