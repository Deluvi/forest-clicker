extends Node2D

onready var grass = preload("res://Grass.tscn")

var radius = 225

var rng = RandomNumberGenerator.new()

func get_random_coord_radius():
	var random_vec = Vector2((rng.randf_range(-1,1)),(rng.randf_range(-1,1))).normalized()
	return random_vec*radius

func bouik():
	$Bouik.stop()
	$Bouik.play("Bouik")

func make_grass(position: Vector2):
	var new_grass = grass.instance()
	new_grass.position = get_random_coord_radius() * 1.1
	orient_obj_to_planet(new_grass)
	add_child(new_grass)

func orient_obj_to_planet(obj: Node2D):
	var planet_coord = self.position
	var angle = (Vector2(0,0).angle_to_point(obj.position)) - 1.570796
	obj.rotation = angle

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
