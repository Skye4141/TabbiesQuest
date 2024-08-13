class_name Card extends Node2D

enum CardType {Arm, Weapon, Spell}


@export var type: CardType = CardType.Arm
@export var cost: IntField
@export var durability: IntField
@export var damage: IntField
@export var title: Label
@export var description: Label

var deckHand: DeckHand

#this should match the Arm or Weapon game object to the card
var arm: MonsterArm
var weapon: MonsterWeapon
@export var playedObjectScene: PackedScene = preload("res://combat/arms/claw.tscn")

func canBePlayed() -> bool:
	if cost.Get() > deckHand.Mana.Get():
		return false
	return true

func onCardPlayed():
	deckHand.Mana.Reduce(cost.Get())


# Called when the node enters the scene tree for the first time.
func _ready():
	showDescription(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func showDescription(show: bool = true):
	if show:
		description.show()
		title.position.y -= 200
	else:
		description.hide()
		title.position.y += 200
