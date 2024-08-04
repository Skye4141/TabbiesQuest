extends Area2D

@export var card: Card

var draggable: bool = false
var isInsideDroppable: bool = false
var droppableBodyRef: DropZone
var isMouseDown: bool = false

func _on_card_body_entered(body: DropZone):
	if body.is_in_group("droppable") and body._is_valid_drop_zone():
		isInsideDroppable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		droppableBodyRef = body
	
func _on_card_body_exited(body: DropZone):
	if body.is_in_group("droppable") and body._is_valid_drop_zone():
		isInsideDroppable = false
		body.modulate = Color(Color.WHITE, 1)
	
func _on_card_mouse_entered():
	if not Util.isCardDragging:
		draggable = true
		card.scale *= Vector2(1.1, 1.1)
	
func _on_card_mouse_exited():
	if not Util.isCardDragging:
		draggable = false
		card.scale /= Vector2(1.1, 1.1)

var dragStartPosition: Vector2
var dragMouseOffset: Vector2
func draggableLogic():
	if draggable:
		if isMouseDown:
			card.global_position = get_global_mouse_position() - dragMouseOffset
		#elif Input.is_action_just_released("left_click"):
			
			
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	draggableLogic()


func _on_mouse_down():
	dragStartPosition = card.position
	dragMouseOffset = get_global_mouse_position() - global_position
	isMouseDown = true


func _on_mouse_up():
	isMouseDown = false
	Util.isCardDragging = false
	var tween = get_tree().create_tween()
	if isInsideDroppable:
		#tween.tween_property(card, "gloabal_postition", droppableBodyRef.global_position, 0.2).set_ease(Tween.EASE_IN_OUT)
		card.onCardPlayed()
		droppableBodyRef._on_dropped(card)
	else:
		tween.tween_property(card, "position", dragStartPosition, 0.2).set_ease(Tween.EASE_IN_OUT)
	
