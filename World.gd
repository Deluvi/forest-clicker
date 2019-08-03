extends Node

var planet_score: float = 0

var tap_number = 0

var last_time_tap = 0

var planet_time_growing: float = 0

export var planet_death_threshold = 100
export var planet_grow_low_threshold = 40
export var planet_grow_high_threshold = 90

func orient_obj_to_planet(obj: Node2D):
	var planet_coord = $Planet.position

	var angle = (planet_coord.angle_to_point(obj.position))
	obj.rotation = angle

func update_score(delta: float):
	print(delta)
	var points = (1/(delta/2000))
	planet_score += points
	print(planet_score)

func tap():
	var time = OS.get_ticks_msec()
	print(time)
	print("Tap")
	$Planet.bouik()
	$Planet.make_grass()
	$Planet.make_small_tree()
	$Planet.make_bush()
	$Planet.progress_life()
	tap_number = tap_number + 1
	#if tap_number == 10:
#		$Planet.start_death()
	update_score(time - last_time_tap)
	last_time_tap = time
	if planet_death_threshold < planet_score:
		$Planet.start_death()

# Called when the node enters the scene tree for the first time.
func _ready():

	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			tap()

func _process(delta):
	planet_score -= (delta/1)
	if planet_score < 0:
		planet_score = 0
	if planet_grow_low_threshold < planet_score and planet_score < planet_grow_high_threshold:
		planet_time_growing += delta


func _on_DeathCooldown_timeout():
	$Planet.start_life()
	planet_score = 0

func _on_Planet_dead():
	$DeathCooldown.start()
