extends Polygon2D

var cog : Node2D
@onready var sceneHandler = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	cog = get_parent()
	self.position = cog.origin + cog.offset
	pass

func _draw():
	draw_rect(Rect2((Vector2(0 + (cog.teethWidth), ( - cog.radius + (cog.teethLength / 2))) - (cog.teethScale)), cog.teethScale), cog.cogColour)
	
	var radius = (cog.teethWidth + cog.teethLength) + cog.teethPointiness
	var center = (Vector2(0, ( - cog.radius + (cog.teethLength / 2))) - (cog.teethScale))
	var angle_from = 180
	var angle_to = 180
	
	draw_circle_arc_poly(center + Vector2(cog.teethWidth,0), radius, angle_from, angle_to + cog.teethPointiness, cog.cogColour)
	draw_circle_arc_poly(center + Vector2(3 * cog.teethWidth,0), radius, angle_from - cog.teethPointiness, angle_to, cog.cogColour)
	
func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()
	points_arc.push_back(center)
	var colors = PackedColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = cog.origin + cog.offset
	queue_redraw()
	pass
