extends Node2D

@onready var ui = $CanvasLayer/UI
@export var cogScene = preload("res://Cog.tscn") # Cog prefab
@export var cogColour = Color.BLACK
@export var backgroundColour = Color.WHITE
@onready var bg_picker_button = $CanvasLayer/UI/HBoxContainer/BGPickerButton
@onready var cog_picker_button = $CanvasLayer/UI/HBoxContainer/CogPickerButton

# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.set_default_clear_color(backgroundColour)
	bg_picker_button.color = backgroundColour
	bg_picker_button.edit_alpha = false
	cog_picker_button.color = cogColour
	cog_picker_button.edit_alpha = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("Add Cog"):
		LoadCog()


func LoadCog():
	# Load new Cog
		var instance = cogScene.instantiate()
		add_child(instance)


func _on_screenshot_but_pressed():
	ui.visible = false
	await get_tree().create_timer(0.01).timeout
	var capture = get_viewport().get_texture().get_image()
	var _time = Time.get_datetime_string_from_system().replacen(":","")
	var filename = "user://Screenshot-{0}.png".format({"0":_time})
	capture.save_png(filename)
	await get_tree().create_timer(0.1).timeout
	ui.visible = true
	
# TODO: Replace with screenspace flash
#	var originalCogColour = cogColour
#	var originalBackgroundColour = backgroundColour
#	cogColour = Color.WHITE
##	backgroundColour = Color.WHITE
#	var flash = create_tween()
#	flash.tween_property(self,"cogColour",originalCogColour,1.0)
#	flash.tween_property(self,"backgroundColour",originalBackgroundColour,1.0)


func _on_quit_but_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_cog_picker_button_color_changed(color):
	cogColour = color


func _on_bg_picker_button_color_changed(color):
	backgroundColour = color
	RenderingServer.set_default_clear_color(color)
