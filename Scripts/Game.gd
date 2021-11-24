extends Node2D

var note = preload("res://Scenes/Note.tscn")
var points = 0

enum{ready,paused}
var status = ready

var energy = 0
var currency = 0 


func _ready():
	$FNF/timers/timer_l.wait_time = rand_range(1,3)
	$FNF/timers/timer_d.wait_time = rand_range(1,3)
	$FNF/timers/timer_u.wait_time = rand_range(1,3)
	$FNF/timers/timer_r.wait_time = rand_range(1,3)
	$FNF/timers/timer_l.start()
	$FNF/timers/timer_d.start()
	$FNF/timers/timer_u.start()
	$FNF/timers/timer_r.start()

	
	
func _process(delta):
	$FNF/Points.text = str(points)
	buttons()
	
	
	$FNF/Turbine.speed_scale = int(points/40)
	$FNF/City.speed_scale = int(points/200)
	if points <= 0:
		points = 0


func buttons():
	if Input.is_action_just_pressed("ui_left") and $FNF/Notes/Left.scale == Vector2(.3,.3):
		$FNF/Notes/Left/area/shape.disabled = false
		$FNF/Notes/Left/left_timer.start()
		$FNF/Notes/Left.scale += Vector2(.1,.1)
		points -= 5
	if $FNF/Notes/Left.scale != Vector2(.3,.3):
		$FNF/Notes/Left.scale -= Vector2(.01,.01)
		if $FNF/Notes/Left.scale <= Vector2(.290,2.90):
			$FNF/Notes/Left.scale = Vector2(.3,.3)
	
	if Input.is_action_just_pressed("ui_down") and $FNF/Notes/Down.scale == Vector2(.3,.3):
		$FNF/Notes/Down/area/shape.disabled = false
		$FNF/Notes/Down/down_timer.start()
		$FNF/Notes/Down.scale += Vector2(.1,.1)
		points -= 5
	if $FNF/Notes/Down.scale != Vector2(.3,.3):
		$FNF/Notes/Down.scale -= Vector2(.01,.01)
		if $FNF/Notes/Down.scale <= Vector2(.290,2.90):
			$FNF/Notes/Down.scale = Vector2(.3,.3)

	if Input.is_action_just_pressed("ui_up") and $FNF/Notes/Up.scale == Vector2(.3,.3):
		$FNF/Notes/Up/area/shape.disabled = false
		$FNF/Notes/Up/up_timer.start()
		$FNF/Notes/Up.scale += Vector2(.1,.1)
		points -= 5
	if $FNF/Notes/Up.scale != Vector2(.3,.3):
		$FNF/Notes/Up.scale -= Vector2(.01,.01)
		if $FNF/Notes/Up.scale <= Vector2(.290,2.90):
			$FNF/Notes/Up.scale = Vector2(.3,.3)
			
	if Input.is_action_just_pressed("ui_right") and $FNF/Notes/Right.scale == Vector2(.3,.3):
		$FNF/Notes/Right/area/shape.disabled = false
		$FNF/Notes/Right/right_timer.start()
		$FNF/Notes/Right.scale += Vector2(.1,.1)
		points -= 5
	if $FNF/Notes/Right.scale != Vector2(.3,.3):
		$FNF/Notes/Right.scale -= Vector2(.01,.01)
		if $FNF/Notes/Right.scale <= Vector2(.290,2.90):
			$FNF/Notes/Right.scale = Vector2(.3,.3)
			
	


func _on_timer_l_timeout():
	if status == ready: 
		var nt = note.instance()
		nt.global_position = Vector2(175,880)
		nt.key = nt.left_key
		nt.rotation_degrees = 90
		add_child(nt)
		$FNF/timers/timer_l.wait_time = rand_range(1,3)


func _on_timer_d_timeout():
	if status == ready:
		var nt = note.instance()
		nt.global_position = Vector2(325,880)
		nt.key = nt.left_key
		nt.rotation_degrees = 0
		add_child(nt)
		$FNF/timers/timer_d.wait_time = rand_range(1,3)

func _on_timer_u_timeout():
	if status == ready:
		var nt = note.instance()
		nt.global_position = Vector2(475,880)
		nt.key = nt.left_key
		nt.rotation_degrees = 180
		add_child(nt)
		$FNF/timers/timer_u.wait_time = rand_range(1,3)


func _on_timer_r_timeout():
	if status == ready:
		var nt = note.instance()
		nt.global_position = Vector2(625,880)
		nt.key = nt.left_key
		nt.rotation_degrees = -90
		add_child(nt)
		$FNF/timers/timer_r.wait_time = rand_range(1,3)


func _on_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("note"):
		## pode ser usado em sistema de pontuação do tipo
		# se abs =< x, critico, se x <= abse < y, ok 
		print(abs(self.global_position.y - area.global_position.y))
		points += 10 
		area.queue_free()


func _on_left_timer_timeout():
	$FNF/Notes/Left/area/shape.disabled = true

func _on_down_timer_timeout():
	$FNF/Notes/Down/area/shape.disabled = true

func _on_up_timer_timeout():
	$FNF/Notes/Up/area/shape.disabled = true

func _on_right_timer_timeout():
	$FNF/Notes/Right/area/shape.disabled = true


func _on_Killzone_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("note"):
		points -= 30
		area.queue_free()



func _on_ready_timer_timeout():
	status = paused
	$FNF/transition_timer.start()


func _on_menu_button_pressed():
	$Next_day/transition.play("event")


func _on_netx_day_button_pressed():
	$Next_day/transition.play("event2")
	yield($Next_day/transition, "animation_finished")
	$Menu/transition.play("event2")


func _on_transition_timer_timeout():
	$Menu/transition.play("event")
