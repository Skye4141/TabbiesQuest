class_name Card extends Node2D

enum CardType {Arm, Weapon, Spell}

@export var type: CardType = CardType.Arm
@export var cost: int
@export var durability: int
@export var damage: int
var deckHand: DeckHand

#this should match the Arm or Weapon game object to the card
var arm: MonsterArm
var weapon: MonsterWeapon
@export var playedObjectScene: PackedScene

func onCardPlayed():
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
