extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles2D.emitting = true

func _process(delta):
	if $Particles2D.emitting == false:
		print("saiu")
		queue_free()
		
