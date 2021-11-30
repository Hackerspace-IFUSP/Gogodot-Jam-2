extends Node2D



func _ready():
	$transition.play("event")
	$beat.play("event")



func _on_Play_pressed():
	$transition.play("event2")
	yield($transition,"animation_finished")
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Credits_button_pressed():
	$change_page.play("event")


func _on_Back_pressed():
	$change_page.play("event2")
