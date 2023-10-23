extends MarginContainer

@onready var sceneHandler = $"../.."

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		sceneHandler.LoadCog()
