extends Node2D

enum {on_dialog,out_dialog}
var status = out_dialog
var wait_time = 2

enum{paused,runing}
var pause = paused

enum{pressed,not_pressed}
var button = not_pressed

var counter = 0

onready var dialog = [
	"Mrs. Reneé: Open your physics textboooks! Any tasks to revieew??", #0
	"Myamoto: No, Mrs!",
	"Mrs. Reneé: Today we are going to resume our lecture about power plants! Can anyone name the ones you knooow?",
	"Sabrina: YESSIR! We have we have Wind, Solar, Hydro, we have have Coal, Gas, Oil and Nuclear!!!",
	"Mrs. Reneé: Well don-",
	"Myamoto: Hey!! What happens if we use all power plants to mine… UnCoin??? It would be awesome! Everyone would become rich!!!",
	"Mrs. Reneé: What abooout the other electric needs of the city?",
	"“Whatever… I just want to play rythm games when I get home.",
	"And finish my energy farm in farmcraft. What if I try to play both at once?",
	"No Mr. GM, I did not use any illegal blocks in construction… I swear… Zzzzzz”"

]


var dialog_index = 0
var finished = false

func _ready():
	load_dialog()

	
func _process(delta):
	dialog_events()
	load_dialog()


func load_dialog():
	if dialog_index < dialog.size() and status == out_dialog:
		status = on_dialog
		$Control/dialogue_timer.start()
		finished = false
		$Control/Dialog_box/RichTextLabel.bbcode_text = dialog[dialog_index]
		$Control/Dialog_box/RichTextLabel.percent_visible = 0
		$Control/Dialog_box/RichTextLabel.push_align(RichTextLabel.ALIGN_CENTER)
		$Control/Dialog_box/Tween.interpolate_property(
			$Control/Dialog_box/RichTextLabel, "percent_visible", 0, 1, wait_time,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Control/Dialog_box/Tween.start()
		yield($Control/Dialog_box/RichTextLabel,"draw")
		
		dialog_index += 1 

	
func dialog_events():
	if dialog_index == 1:
		$"Control/Dialog_box/RichTextLabel".modulate = Color(0,0,0,1)
	if dialog_index == 2:
		$"Control/Dialog_box/RichTextLabel".modulate = Color(0,1,0,1)
	if dialog_index == 3:
		$"Control/Dialog_box/RichTextLabel".modulate = Color(0,0,0,1)
	if dialog_index == 4:
		$"Control/Dialog_box/RichTextLabel".modulate = Color(1,0,0,1)
	if dialog_index == 5:
		$"Control/Dialog_box/RichTextLabel".modulate = Color(0,0,0,1)
	if dialog_index == 6:
		$"Control/Dialog_box/RichTextLabel".modulate = Color(0,1,0,1)
	if dialog_index == 7:
		$"Control/Dialog_box/RichTextLabel".modulate = Color(0,0,0,1)
	if dialog_index == 8:
		$"Control/Dialog_box/RichTextLabel".modulate = Color(0,0,1,1)

	
	if dialog_index == dialog.size():
		$transition.play("event")
		yield($transition,"animation_finished")
		get_tree().change_scene("res://Scenes/Title_screen.tscn")
		

func _on_Tween_tween_completed(object, key):
	finished = true

func _on_dialogue_timer_timeout():
	status = out_dialog


func _on_Next_pressed():
	button = pressed




func _on_Skip_pressed():
	$transition.play("event")
	yield($transition,"animation_finished")
	get_tree().change_scene("res://Scenes/Title_screen.tscn")
