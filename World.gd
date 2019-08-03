extends Node

var forest_score = 0

export var forest_threshold = 100



func orient_obj_to_planet(obj: Node2D):
	var planet_coord = $Planet.position

	var angle = (planet_coord.angle_to_point(obj.position))
	obj.rotation = angle

func tap():
	print("Tap")
	$Planet.bouik()
	$Planet.make_grass()
	$Planet.make_small_tree()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			tap()
			$Planet.start_death()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
