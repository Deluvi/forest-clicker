extends Node

var planet_score: float = 0

var planet_dying = false

var tap_number = 0

var last_time_tap = 0

var planet_time_growing: float = 0
var next_level_growing = 5
var planet_score_reduction = 5

var first_tap = false

var first_tap_planet = false

export var planet_sleepy_threshold = 70
export var planet_grow_low_threshold = 90
export var planet_grow_high_threshold = 190
export var planet_hurt_threshold_1 = 200
export var planet_hurt_threshold_2 = 225
export var planet_death_threshold = 250

func orient_obj_to_planet(obj: Node2D):
	var planet_coord = $Planet.position

	var angle = (planet_coord.angle_to_point(obj.position))
	obj.rotation = angle

func update_score(delta: float):
	var points = 10
	planet_score += points
	print(planet_score)
	print(planet_time_growing)

func tap():
	if ! first_tap:
		$AnimationExit.play("Title ninja exit")
		first_tap = true
	
	if ! first_tap_planet:
		$Ambient.play()
		first_tap_planet = true
	var time = OS.get_ticks_msec()
	$Planet.bouik()
	tap_number = tap_number + 1
	update_score(time - last_time_tap)
	last_time_tap = time
	update_planet_visual()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			tap()

func _process(delta):
	planet_score -= (delta*planet_score_reduction)
	if planet_score < 0:
		planet_score = 0
	if planet_grow_low_threshold < planet_score and planet_score < planet_grow_high_threshold:
		planet_time_growing += delta
	if planet_score < planet_sleepy_threshold:
		planet_time_growing -= delta
	if planet_time_growing > next_level_growing:
		$Planet.progress_life()
		planet_time_growing = 0
	if planet_time_growing < 0:
		$Planet.decrease_life()
		planet_time_growing = next_level_growing
	update_planet_visual()

func update_planet_visual():
	if ! planet_dying:
		if planet_death_threshold < planet_score:
			$Planet.start_death()
			$DeathMusic.play()
			$Ambient.stop()
			$GameMade.visible = false
			$Credit.visible = false
			planet_dying = true
		elif planet_hurt_threshold_2 < planet_score:
			$Planet.display_hurt_2()
		elif planet_hurt_threshold_1 < planet_score:
			$Planet.display_hurt_1()
		else:
			$Planet.resume_life()

func _on_DeathMusic_finished():
	$AnimationRespawn.play("Respawn")

func restart_planet():
	$Planet.start_life()
	planet_score = 0
	planet_dying = false
	first_tap_planet = false
	planet_time_growing = 0

func _on_Planet_woken():
	$WinMusic.play()
	$Ambient.stop()
	$GameMade.visible = true
	$Credit.visible = true

func _on_WinMusic_finished():
	$Ambient.play()
