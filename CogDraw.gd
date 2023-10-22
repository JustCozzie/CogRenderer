extends Node2D

@onready var sceneHandler = $".."


@export_group("Cog")
var origin : Vector2
@export var offset : Vector2 # Move cog in 2D space
@export var radius = 100 # Size of cog
@export var holeSize = 50 # TODO currently arbitrary. Make a Percentage. 100 is invisible, 0 is no hole

var cogColour = Color.BLACK

@export_group("Teeth")
@export var teethScene = preload("res://tooth.tscn") # Tooth prefab
@export var teethWidth = 50
@export var teethLength = 50
@export var teethNumber = 14 # How many teeth on gear
@export var teethPointiness = 0 # Degrees. 0 is straight, higher numbers give diagonal sides to teeth

var oldTeethNumber = teethNumber
var teethScale = Vector2(2 * teethWidth, 2 * teethLength)

# Called when the node enters the scene tree for the first time.
func _ready():
	origin = get_viewport().get_mouse_position()
	cogColour = sceneHandler.cogColour
	LoadTeeth()
	pass # Replace with function body.


func _draw():
	# draws cog and inner circle
	draw_circle((origin + offset), radius, cogColour)
	draw_circle((origin + offset), (radius / 100) * holeSize, sceneHandler.backgroundColour)
	pass

# Loads and childs required number of teeth at set degrees of rotation around cog
func LoadTeeth():
	# Unload current teeth
	for n in self.get_children():
		self.remove_child(n)
		n.queue_free()
	# Load new teeth
	var i = 0
	while i < teethNumber:	
		var instance = teethScene.instantiate()
		add_child(instance)
		instance.rotate(deg_to_rad((360 / (teethNumber - 0.0)) * i))
		i += 1
	oldTeethNumber = teethNumber

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get middle of viewport
#	origin = get_viewport_rect().size / 2
	
	if teethNumber != oldTeethNumber:
		LoadTeeth()
	
	teethScale = Vector2(2 * teethWidth, 2 * teethLength)
	queue_redraw()
	pass
