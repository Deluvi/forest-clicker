extends Node

onready var grass = preload("res://Grass.tscn")

func make_grass(position: Vector2):
	var new_grass = grass.instance()
	new_grass.position = position
	orient_obj_to_planet(new_grass)
	#add_child_below_node(new_grass, $ColorRect)
	add_child(new_grass)

func orient_obj_to_planet(obj: Node2D):
	var planet_coord = $Planet.position
	#var rotation = atan2(obj.position.y - planet_coord.y, obj.position.x - planet_coord.x)
	#obj.set_rotation(planet_coord.angle_to(obj.position))
	#obj.set_rotation(obj.position.angle_to(planet_coord))
	
	#var angle = (VisualScriptMathConstant.MATH_CONSTANT_HALF_PI) + (obj.position - planet_coord).angle()
	var angle = 1.570796 + (obj.position - planet_coord).angle()
	print(angle)
	print((obj.position - planet_coord).angle())
	obj.rotation = angle

func tap():
	print("Tap")

# Called when the node enters the scene tree for the first time.
func _ready():
	orient_obj_to_planet($Grass)
	make_grass(Vector2(50,50))

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			tap()
			make_grass(event.position)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
