extends Node2D

func _ready():
	$Animation.play("default")
	$Animation.speed_scale = randf()*0.25+0.50
	$Animation.set_frame(0)

func alternative1():
	$Animation.play("alternative1")

func alternative2():
	$Animation.play("alternative2")