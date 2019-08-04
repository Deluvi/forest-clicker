extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Animation.play("default")
	$Animation.speed_scale = randf()*0.25 + 0.30
	$Animation.set_frame(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
