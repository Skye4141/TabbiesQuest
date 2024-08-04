class_name DeckHand extends Control

@export var startingHandSize: int = 3
var Deck: Array[Card]
var Hand: Array[Card] = [null, null, null, null, null, null, null, null]
var Discard: Array[Card]
var InPlay: Array[Card]
var Grave: Array[Card]

var center: float = 150 #x coord for putting cards
const yCoords = [200, 400, 600, 800, 600, 700, 800, 900]
var testCardScene: PackedScene = preload("res://Card.tscn")

func loadDeck():
	#TODO: replace packed scenes with scenes from game deck collection, or duplicate
	for i in range(15):
		var newCard: Card = testCardScene.instantiate()
		add_child(newCard)
		newCard.scale = Vector2(.5, .5)
		newCard.hide()
		Deck.append(newCard)
		Deck.shuffle()

func undrawCards():
	for i in range(Hand.size()):
		discardIndex(i)

#does not reset Hand to sequential card state		
func discardIndex(index: int):
	var card: Card = Hand[index]
	if not card:
		return
	Discard.append(card)
	card.hide()
	Hand[index] = null

func discardCard(card: Card):
	for i in range(Hand.size()):
		if Hand[i] == card:
			discardIndex(i)
			resetHand()
			return

func playCard(card: Card):
	for i in range(Hand.size()):
		if Hand[i] == card:
			InPlay.append(card)
			Hand[i] = null
			resetHand()
			return

func resetHand():
	var temp: Array[Card] = []
	for i in range(Hand.size()):
		if Hand[i]:
			temp.append(Hand[i])
	for i in range(temp.size()):
		Hand[i] = temp[i]
		Hand[i].position = Vector2(center, yCoords[i])

func drawCard() -> int:
	if Deck.size() == 0:
		reshuffleDiscard()
		if Deck.size() == 0:
			return -1
	for i in range(Hand.size()):
		if not Hand[i]:
			var card: Card = Deck.pop_back()
			Hand[i] = card
			card.position = Vector2(center, yCoords[i])
			card.show()
			return i
	#TODO: play animation hand full
	return -1

func drawCards(amount: int):
	for i in range(amount):
		drawCard()

func reshuffleDiscard():
	Deck.append_array(Discard)
	Discard.clear()
	Deck.shuffle()
	#TODO: play reshuffle animation and/or sound

# Called when the node enters the scene tree for the first time.
func _ready():
	center = position.x + (size.x / 2)
	loadDeck()
	drawCards(startingHandSize)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
