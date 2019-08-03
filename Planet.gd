extends Node2D

onready var grass = preload("res://Grass.tscn")
onready var small_tree = preload("res://SmallTree.tscn")

var radius = 225

var rng = RandomNumberGenerator.new()

func get_random_coord_radius():
	var random_vec = Vector2((rng.randf_range(-1,1)),(rng.randf_range(-1,1))).normalized()
	return random_vec*radius

func bouik():
	$Bouik.stop()
	$Bouik.play("Bouik")

func make_veg(scene: PackedScene, coef: float):
	var new_veg = scene.instance()
	new_veg.position = get_random_coord_radius() * coef
	orient_obj_to_planet(new_veg)
	add_child(new_veg)

func make_grass():
	make_veg(grass, 1.02)

func make_small_tree():
	make_veg(small_tree, 1)

func orient_obj_to_planet(obj: Node2D):
	var angle = (Vector2(0,0).angle_to_point(obj.position)) - 1.570796
	obj.rotation = angle

func start_death():
	$AnimatedSprite.play("death")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
