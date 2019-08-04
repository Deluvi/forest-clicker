extends Node2D

onready var grass = preload("res://Grass.tscn")
onready var small_tree = preload("res://SmallTree.tscn")
onready var bush = preload("res://Bush.tscn")

signal dead

var dying = false

var life_level = 0

var veg = []

var radius = 225

var rng = RandomNumberGenerator.new()

func get_random_coord_radius():
	var random_vec = Vector2((rng.randf_range(-1,1)),(rng.randf_range(-1,1))).normalized()
	return random_vec*radius

func bouik():
	if ! dying:
		$Bouik.stop()
		$Bouik.play("Bouik")
		$BouikSound.play()

func make_veg(scene: PackedScene, coef: float):
	if ! dying:
		var new_veg = scene.instance()
		new_veg.position = get_random_coord_radius() * coef
		orient_obj_to_planet(new_veg)
		add_child(new_veg)
		veg.push_back(new_veg)

func make_grass():
	make_veg(grass, 1.02)

func make_small_tree():
	make_veg(small_tree, 1)

func make_bush():
	make_veg(bush, 1)

func orient_obj_to_planet(obj: Node2D):
	var angle = (Vector2(0,0).angle_to_point(obj.position)) - 1.570796
	obj.rotation = angle

func display_hurt_1():
	$AnimatedSprite.play("hurt")
	$AnimatedSprite.frame = 0
	$AnimatedSprite.stop()

func display_hurt_2():
	$AnimatedSprite.play("hurt")
	$AnimatedSprite.frame = 1
	$AnimatedSprite.stop()

func start_death():
	$AnimatedSprite.play("death")
	dying = true

func start_life():
	$AnimatedSprite.play("reveil")
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = 0
	life_level = 0
	dying = false

func _ready():
	start_life()

func progress_life():
	if ! dying:
		life_level += 1
		$AnimatedSprite.frame = life_level

func resume_life():
	$AnimatedSprite.play("reveil")
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = life_level

func _on_AnimatedSprite_animation_finished():
	if dying:
		emit_signal("dead")
		for veg_inst in veg:
			veg_inst.queue_free()
		veg.clear()

func _on_AnimatedSprite_frame_changed():
	if dying:
		remove_veg(veg.size()/2)

func remove_veg(amount: int):
	for _i in range(amount):
		var veg_inst = veg.pop_back()
		veg_inst.queue_free()