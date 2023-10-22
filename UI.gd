extends MarginContainer

@onready var sceneHandler = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		sceneHandler.LoadCog()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
