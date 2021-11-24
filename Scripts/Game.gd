extends Node2D

var note = preload("res://Scenes/Note.tscn")

func _ready():
	$timers/timer_l.wait_time = rand_range(1,3)
	$timers/timer_d.wait_time = rand_range(1,3)
	$timers/timer_u.wait_time = rand_range(1,3)
	$timers/timer_r.wait_time = rand_range(1,3)

	$timers/timer_l.start()
	$timers/timer_d.start()
	$timers/timer_u.start()
	$timers/timer_r.start()
	
	
	
func _process(delta):
	buttons()


func buttons():
	if Input.is_action_just_pressed("ui_left") and $Notes/Left.scale == Vector2(.3,.3):
		$Notes/Left/area/shape.disabled = false
		$Notes/Left/left_timer.start()
		$Notes/Left.scale += Vector2(.1,.1)
	if $Notes/Left.scale != Vector2(.3,.3):
		$Notes/Left.scale -= Vector2(.01,.01)
		if $Notes/Left.scale <= Vector2(.290,2.90):
			$Notes/Left.scale = Vector2(.3,.3)
	
	if Input.is_action_just_pressed("ui_down") and $Notes/Down.scale == Vector2(.3,.3):
		$Notes/Down/area/shape.disabled = false
		$Notes/Down/down_timer.start()
		$Notes/Down.scale += Vector2(.1,.1)
	if $Notes/Down.scale != Vector2(.3,.3):
		$Notes/Down.scale -= Vector2(.01,.01)
		if $Notes/Down.scale <= Vector2(.290,2.90):
			$Notes/Down.scale = Vector2(.3,.3)

	if Input.is_action_just_pressed("ui_up") and $Notes/Up.scale == Vector2(.3,.3):
		$Notes/Up/area/shape.disabled = false
		$Notes/Up/up_timer.start()
		$Notes/Up.scale += Vector2(.1,.1)
	if $Notes/Up.scale != Vector2(.3,.3):
		$Notes/Up.scale -= Vector2(.01,.01)
		if $Notes/Up.scale <= Vector2(.290,2.90):
			$Notes/Up.scale = Vector2(.3,.3)
			
	if Input.is_action_just_pressed("ui_right") and $Notes/Right.scale == Vector2(.3,.3):
		$Notes/Right/area/shape.disabled = false
		$Notes/Right/right_timer.start()
		$Notes/Right.scale += Vector2(.1,.1)
	if $Notes/Right.scale != Vector2(.3,.3):
		$Notes/Right.scale -= Vector2(.01,.01)
		if $Notes/Right.scale <= Vector2(.290,2.90):
			$Notes/Right.scale = Vector2(.3,.3)


func _on_timer_l_timeout():
	var nt = note.instance()
	nt.global_position = Vector2(80,880)
	nt.key = nt.left_key
	nt.rotation_degrees = 90
	add_child(nt)
	$timers/timer_l.wait_time = rand_range(1,3)


func _on_timer_d_timeout():
	var nt = note.instance()
	nt.global_position = Vector2(230,880)
	nt.key = nt.left_key
	nt.rotation_degrees = 0
	add_child(nt)
	$timers/timer_d.wait_time = rand_range(1,3)

func _on_timer_u_timeout():
	var nt = note.instance()
	nt.global_position = Vector2(380,880)
	nt.key = nt.left_key
	nt.rotation_degrees = 180
	add_child(nt)
	$timers/timer_u.wait_time = rand_range(1,3)


func _on_timer_r_timeout():
	var nt = note.instance()
	nt.global_position = Vector2(530,880)
	nt.key = nt.left_key
	nt.rotation_degrees = -90
	add_child(nt)
	$timers/timer_r.wait_time = rand_range(1,3)


func _on_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("note"):
		## pode ser usado em sistema de pontuação do tipo
		# se abs =< x, critico, se x <= abse < y, ok 
		print(abs(self.global_position.y - area.global_position.y))
		area.queue_free()


func _on_left_timer_timeout():
	$Notes/Left/area/shape.disabled = true

func _on_down_timer_timeout():
	$Notes/Down/area/shape.disabled = true

func _on_up_timer_timeout():
	$Notes/Up/area/shape.disabled = true

func _on_right_timer_timeout():
	$Notes/Right/area/shape.disabled = true
