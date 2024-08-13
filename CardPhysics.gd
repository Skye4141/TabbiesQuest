extends Area2D

@export var card: Card

var draggable: bool = false
var isInsideDroppable: bool = false
var droppableBodyRef: DropZone
var isMouseDown: bool = false
var startingScale: Vector2

func _on_card_body_entered(body: DropZone):
	if body.is_in_group("droppable") and body._is_valid_drop_zone():
		isInsideDroppable = true
		droppableBodyRef = body
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		print(body.get_child(1), body.get_child(1).modulate.a)
		var colorRect: ColorRect = body.get_child(1)
		colorRect.color.a = 1
	
func _on_card_body_exited(body: DropZone):
	if body.is_in_group("droppable") and body._is_valid_drop_zone():
		isInsideDroppable = false
		body.modulate = Color(Color.WHITE, 1)
		var colorRect: ColorRect = body.get_child(1)
		colorRect.color.a = 0.1
	
func _on_card_mouse_entered():
	if not Util.isCardDragging:
		#startingScale = card.scale
		draggable = true
		print("scale at mouse entered", scale)
		card.scale = startingScale * Vector2(2, 2)
		card.showDescription(true)
		card.z_index += 1
	
func _on_card_mouse_exited():
	if not Util.isCardDragging:
		draggable = false
		card.scale = startingScale
		card.showDescription(false)
		card.z_index -= 1

var dragStartPosition: Vector2
var dragMouseOffset: Vector2
func draggableLogic():
	if draggable and card.canBePlayed():
		if isMouseDown:
			card.global_position = get_global_mouse_position() - dragMouseOffset
		#elif Input.is_action_just_released("left_click"):
			
			
# Called when the node enters the scene tree for the first time.
func _ready():
	startingScale = card.scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	draggableLogic()

func dragStart():
	dragStartPosition = card.position
	dragMouseOffset = get_global_mouse_position() - global_position
	isMouseDown = true
	Util.isCardDragging = true
	card.scale = startingScale / Vector2(2, 2)

func _on_mouse_down():
	if draggable and card.canBePlayed():
		dragStart()


func dragEnd():
	isMouseDown = false
	Util.isCardDragging = false
	var tween = get_tree().create_tween()
	#card.scale *= Vector2(4, 4)
	if isInsideDroppable:
		#tween.tween_property(card, "gloabal_postition", droppableBodyRef.global_position, 0.2).set_ease(Tween.EASE_IN_OUT)
		card.onCardPlayed()
		droppableBodyRef._on_dropped(card)
	else:
		tween.tween_property(card, "position", dragStartPosition, 0.2).set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		card.scale = startingScale

func _on_mouse_up():
	if draggable and Util.isCardDragging:
		dragEnd()
	
	
