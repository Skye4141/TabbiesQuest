extends ColorRect

@export var header: Label
@export var body: Label
@export var headerText: String
@export var bodyText: String

# Called when the node enters the scene tree for the first time.
func _ready():
	header.text = headerText
	body.text = bodyText


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
