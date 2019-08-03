extends Node

var forest_score: float = 0

var tap_number = 0

var last_time_tap = 0

export var forest_threshold = 100

func orient_obj_to_planet(obj: Node2D):
	var planet_coord = $Planet.position

	var angle = (planet_coord.angle_to_point(obj.position))
	obj.rotation = angle

func update_score(delta: float):
	print(delta)
	var points = (1/(delta/2000))
	forest_score += points
	print(forest_score)

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
	if forest_threshold < forest_score:
		$Planet.start_death()

# Called when the node enters the scene tree for the first time.
func _ready():

	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			tap()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DeathCooldown_timeout():
	$Planet.start_life()
	forest_score = 0


func _on_Planet_dead():
	$DeathCooldown.start()
