extends Node2D

var note = preload("res://Scenes/Note.tscn")


func _ready():
	pass

func _on_timer_1_timeout():
	var nt = note.instance()
	nt.global_position = Vector2(204,620)
	nt.key = nt.left_key
	add_child(nt)
	$timer_1.wait_time = rand_range(1,3)

func _on_timer_2_timeout():
	var nt = note.instance()
	nt.global_position = Vector2(408,620)
	nt.key = nt.down_key
	add_child(nt)
	$timer_2.wait_time = rand_range(1,3)

func _on_timer_3_timeout():
	var nt = note.instance()
	nt.global_position = Vector2(612,620)
	nt.key = nt.up_key
	add_child(nt)
	$timer_3.wait_time = rand_range(1,3)

func _on_timer_4_timeout():
	var nt = note.instance()
	nt.global_position = Vector2(816,620)
	nt.key = nt.right_key
	add_child(nt)
	$timer_4.wait_time = rand_range(1,3)
