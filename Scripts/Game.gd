extends Node2D

var note = preload("res://Scenes/Note.tscn")
onready var ok = preload("res://Scenes/Ok.tscn")
var points = 0



enum{ready,paused}
var status = ready

var energy = 0
var day_coin = 0 
var coin = 0 
var day = 0 
var bonus = 0

enum{on_keys,out_keys}
var keys = on_keys


enum{level_1,level_2,level_3}
var level = level_1

func _ready():
####FNF ready####
	$transition.play("event")
	$FNF/timers/timer_l.wait_time = rand_range(1,3)
	$FNF/timers/timer_d.wait_time = rand_range(1,3)
	$FNF/timers/timer_u.wait_time = rand_range(1,3)
	$FNF/timers/timer_r.wait_time = rand_range(1,3)
	$FNF/timers/timer_l.start()
	$FNF/timers/timer_d.start()
	$FNF/timers/timer_u.start()
	$FNF/timers/timer_r.start()
####################
	$HUD/TimeLeft.text = str(int($FNF/ready_timer.time_left) + 1)
	


func _process(delta):
	
################# timer
	$HUD/TimeLeft.text = str(int($FNF/ready_timer.time_left) + 1)
	



####FNF Process####
	
	if keys == on_keys:
		buttons()
		
	points_update()

####################

####FNF Funcs####

func buttons():
	if Input.is_action_just_pressed("ui_left") and $FNF/Notes/Left.scale == Vector2(.3,.3):
		$FNF/Notes/Left/area/shape.disabled = false
		$FNF/Notes/Left/left_timer.start()
		$FNF/Notes/Left.scale += Vector2(.1,.1)
		$FNF/Notes/Left/AudioStreamPlayer.play()
		points -= 5
	if $FNF/Notes/Left.scale != Vector2(.3,.3):
		$FNF/Notes/Left.scale -= Vector2(.01,.01)
		if $FNF/Notes/Left.scale <= Vector2(.290,2.90):
			$FNF/Notes/Left.scale = Vector2(.3,.3)
	
	if Input.is_action_just_pressed("ui_down") and $FNF/Notes/Down.scale == Vector2(.3,.3):
		$FNF/Notes/Down/area/shape.disabled = false
		$FNF/Notes/Down/down_timer.start()
		$FNF/Notes/Down.scale += Vector2(.1,.1)
		$FNF/Notes/Down/AudioStreamPlayer.play()
		points -= 5
	if $FNF/Notes/Down.scale != Vector2(.3,.3):
		$FNF/Notes/Down.scale -= Vector2(.01,.01)
		if $FNF/Notes/Down.scale <= Vector2(.290,2.90):
			$FNF/Notes/Down.scale = Vector2(.3,.3)

	if Input.is_action_just_pressed("ui_up") and $FNF/Notes/Up.scale == Vector2(.3,.3):
		$FNF/Notes/Up/area/shape.disabled = false
		$FNF/Notes/Up/up_timer.start()
		$FNF/Notes/Up.scale += Vector2(.1,.1)
		$FNF/Notes/Up/AudioStreamPlayer.play()
		points -= 5
	if $FNF/Notes/Up.scale != Vector2(.3,.3):
		$FNF/Notes/Up.scale -= Vector2(.01,.01)
		if $FNF/Notes/Up.scale <= Vector2(.290,2.90):
			$FNF/Notes/Up.scale = Vector2(.3,.3)
			
	if Input.is_action_just_pressed("ui_right") and $FNF/Notes/Right.scale == Vector2(.3,.3):
		$FNF/Notes/Right/area/shape.disabled = false
		$FNF/Notes/Right/right_timer.start()
		$FNF/Notes/Right.scale += Vector2(.1,.1)
		$FNF/Notes/Right/AudioStreamPlayer.play()
		points -= 5
	if $FNF/Notes/Right.scale != Vector2(.3,.3):
		$FNF/Notes/Right.scale -= Vector2(.01,.01)
		if $FNF/Notes/Right.scale <= Vector2(.290,2.90):
			$FNF/Notes/Right.scale = Vector2(.3,.3)

func points_update():
	$FNF/Points.text = str("points: ", points)
	$FNF/Turbine.speed_scale = int(points/40)
	$FNF/City.speed_scale = int(points/200)
	$HUD/Day.text =  str("Day: ", day)
	if points <= 0:
		points = 0
			
func _on_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("note"):
		points += 15 
		var correct = ok.instance()
		correct.global_position = area.global_position
		add_child(correct)
		area.queue_free()
		
func _on_Killzone_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("note"):
		points -= 20
		area.queue_free()

####################

####Menu Funcs####
func _on_menu_button_pressed():
	$Menu/transition.play("event2")
	yield($Menu/transition, "animation_finished")
	$Next_day/transition.play("event2")
	$FNF/ready_timer.start()
	points = 0
	day += 1
	status = ready
	keys = on_keys
	
func _on_solar_panel_pressed(): 
	if coin >= 100:
		coin -= 100
		bonus += 10
		level = level_2
		$Menu/upgrades/Animations/Solar_panel.play("event")
		$Menu/upgrades/Buttons/solar_panel.disabled = true
		yield($Menu/upgrades/Animations/Solar_panel,"animation_finished")
		$Menu/upgrades/Animations/Solar_panel.queue_free()
		$Menu/upgrades/Buttons/solar_panel.queue_free()
		$Menu/upgrades/Graphics/Solar_panel.playing = true
		$Menu/Money.text = str("Cashcoin: ", coin)
		$Diolog.show()
		$Diolog.pause = $Diolog.paused
		$Diolog.dialog = $Diolog.text1
		$Diolog.load_dialog()
	else:
		pass
	
func _on_Hydrelectric_pressed():
	if coin >= 300:
		coin -= 300
		bonus += 30
		level = level_3
		$Menu/upgrades/Animations/Hydroelectric.play("event")
		$Menu/upgrades/Buttons/Hydrelectric.disabled = true
		yield($Menu/upgrades/Animations/Hydroelectric,"animation_finished")
		$Menu/upgrades/Animations/Hydroelectric.queue_free()
		$Menu/upgrades/Buttons/Hydrelectric.queue_free()
		$Menu/upgrades/Graphics/Hydroelectric.playing = true
		$Menu/Money.text = str("Cashcoin: ", coin)
		$Diolog.show()
		$Diolog.pause = $Diolog.paused
		$Diolog.dialog = $Diolog.text2
		$Diolog.load_dialog()


func _on_Reactor_pressed():
	if coin >= 1000:
		coin -= 1000
		bonus += 500
		$Menu/upgrades/Animations/Reactor.play("event")
		$Menu/upgrades/Buttons/Reactor.disabled = true
		yield($Menu/upgrades/Animations/Reactor,"animation_finished")
		$Menu/upgrades/Animations/Reactor.queue_free()
		$Menu/upgrades/Buttons/Reactor.queue_free()
		$Menu/upgrades/Graphics/Reactor.playing = true
		$Menu/Money.text = str("Cashcoin: ", coin)
		$Diolog.show()
		$Diolog.pause = $Diolog.paused
		$Diolog.dialog = $Diolog.text3
		$Diolog.awake = 1
		$Diolog.load_dialog()


####################

####Next day Funcs ####
func _on_netx_day_button_pressed():
	$Menu/transition.play("event")

####################

####FNF Timers####
func _on_timer_l_timeout():
	if status == ready: 
		var nt = note.instance()
		nt.global_position = Vector2(175,880)
		nt.key = nt.left_key
		nt.rotation_degrees = 90
		
		add_child(nt)
		if level == level_1:
			$FNF/timers/timer_l.wait_time = rand_range(2,3.5)
		elif level == level_2:
			$FNF/timers/timer_l.wait_time = rand_range(1,3)
		elif level == level_3:
			$FNF/timers/timer_l.wait_time = rand_range(.8,2.5)


func _on_timer_d_timeout():
	if status == ready:
		var nt = note.instance()
		nt.global_position = Vector2(325,880)
		nt.key = nt.left_key
		nt.rotation_degrees = 0
		add_child(nt)
		if level == level_1:
			$FNF/timers/timer_l.wait_time = rand_range(2,3.5)
		elif level == level_2:
			$FNF/timers/timer_l.wait_time = rand_range(1,3)
		elif level == level_3:
			$FNF/timers/timer_l.wait_time = rand_range(.8,2.5)

func _on_timer_u_timeout():
	if status == ready:
		var nt = note.instance()
		nt.global_position = Vector2(475,880)
		nt.key = nt.left_key
		nt.rotation_degrees = 180
		add_child(nt)
		if level == level_1:
			$FNF/timers/timer_l.wait_time = rand_range(2,3.5)
		elif level == level_2:
			$FNF/timers/timer_l.wait_time = rand_range(1,3)
		elif level == level_3:
			$FNF/timers/timer_l.wait_time = rand_range(.8,2.5)


func _on_timer_r_timeout():
	if status == ready:
		var nt = note.instance()
		nt.global_position = Vector2(625,880)
		nt.key = nt.left_key
		nt.rotation_degrees = -90
		add_child(nt)
		if level == level_1:
			$FNF/timers/timer_l.wait_time = rand_range(2,3.5)
		elif level == level_2:
			$FNF/timers/timer_l.wait_time = rand_range(1,3)
		elif level == level_3:
			$FNF/timers/timer_l.wait_time = rand_range(.8,2.5)


func _on_left_timer_timeout():
	$FNF/Notes/Left/area/shape.disabled = true

func _on_down_timer_timeout():
	$FNF/Notes/Down/area/shape.disabled = true

func _on_up_timer_timeout():
	$FNF/Notes/Up/area/shape.disabled = true

func _on_right_timer_timeout():
	$FNF/Notes/Right/area/shape.disabled = true


func _on_ready_timer_timeout():
	status = paused
	$FNF/transition_timer.start()

func _on_transition_timer_timeout():
	energy = points
	keys = out_keys
	if level == level_1:
		day_coin = int(rand_range(0.06 * energy, .10*energy))
		
	elif level == level_2:
		day_coin = 2*int(rand_range(0.06 * energy, .10*energy))

	elif level == level_3:
		day_coin = 3*int(rand_range(0.06 * energy, .10*energy))
		
		
	coin += day_coin + bonus
	$Next_day/Report/Energy_earned.text = str("Energy earned: ", energy, " MWh")
	$Next_day/Report/Bonus.text = str("Bonus: ", bonus, " MWh")
	$Next_day/Report/Godotcoin.text = str("U coins earned: ", day_coin)
	$Next_day/transition.play("event")
	$Next_day/Report/Total.text = str("Total: ", coin)
	$Menu/Money.text = str("Cashcoin: ", coin)
	

####################



func _on_Back_pressed():
	$"Thanks/transition".play("event2")
