extends Area2D

var speed = Vector2(0,-400)
enum{right_key, left_key, up_key, down_key}
var key = right_key
enum{out_key,on_key}
var status = out_key

func _ready():
	pass

func _process(delta):
	translate(speed*delta)
	if (Input.is_action_just_pressed("ui_left") and key == left_key) or (Input.is_action_just_pressed("ui_right") and key == right_key) or (Input.is_action_just_pressed("ui_up") and key == up_key) or (Input.is_action_just_pressed("ui_down") and key == down_key):
		if status == on_key:
			queue_free()


func _on_Note_area_entered(area):
	if area.is_in_group("key"):
		status = on_key
